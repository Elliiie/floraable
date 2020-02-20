from flask import Blueprint, render_template, redirect, url_for, request, flash, session
from flask_login import login_required, current_user
from .models import Device, User, UserDevice, TemperatureSensorValue, MoistureSensorValue, LightSensorValue
import paho.mqtt.client as mqtt
from . import db
from . import socketio
from keystoneclient import session as ksc_session


main = Blueprint('main', __name__)
mqttc = mqtt.Client()

@main.route("/")
def index():
    return render_template('index.html')
    
@main.route("/profile")
@login_required
def profile():
    devices = Device.query.join(UserDevice).join(User).filter((UserDevice.c.user_id == current_user.id)).all()
    return render_template('profile.html',  devices = devices,  async_mode=socketio.async_mode)

@main.route("/profile/add_device", methods=['GET','POST'])
@login_required
def addDevice():
    if request.method == 'POST':

        name = request.form.get('name')
        serialNum = request.form.get('serialNum')

        device = Device.query.filter_by(serialNum = serialNum).first()

        if device:
            db.create_all()
            current_user.device.append(device)
            db.session.commit()
        
        else:
            db.create_all()
            new_device = Device(name=name, serialNum = serialNum)
            current_user.device.append(new_device)
            db.session.commit()
            
        return redirect(url_for('main.profile'))

    else:
        return render_template('deviceAdder.html')


@main.route("/profile/<string:device>/<board>/delete")
def deleteDevice(device, board):
    if request.method == 'POST':

        serialNum = device

        Device.delete().where(Device.c.serialNum==serialNum)                               

        return redirect(url_for('main.profile'))

    else:
        return redirect(url_for('main.profile'))


def on_connect(client, userdata, flags, rc):
        print("Connected with result code "+str(rc))
        print("zdr")
        client.subscribe("/profile/4131074/esp8266/temperature")
        client.subscribe("/profile/4131074/esp8266/humidity")
        client.subscribe("/profile/4131074/esp8266/soilmoisture")
        client.subscribe("/profile/4131074/esp8266/light")

def on_message(client, userdata, message):

    print("Received message '" + str(message.payload) + "' on topic '" + message.topic + "' with QoS " + str(message.qos))

    if message.topic == "/profile/4131074/esp8266/temperature":
        print("temperature update")

        socketio.emit('dht_temperature', {'data' : message.payload})


    if message.topic == "/profile/4131074/esp8266/humidity":
        print("humidity update")

        socketio.emit('dht_humidity', {'data' : message.payload})
        
    if message.topic == "/profile/4131074/esp8266/soilmoisture":
        print("soil moisture update")

        socketio.emit('soil_moisture', {'data' : message.payload})

    if message.topic == "/profile/4131074/esp8266/light":
        print("light update")

        socketio.emit('light_sensor', {'data' : message.payload})
        
mqttc.on_connect = on_connect
mqttc.on_message = on_message
mqttc.connect("localhost", 1883, 60)
mqttc.loop_start()

pins = {
    12 : {'name' : 'GPIO 12', 'board' : 'esp8266', 'topic' : 'profile/4131074/esp8266/12', 'state' : 'False'},
    13 : {'name' : 'GPIO 15', 'board' : 'esp8266', 'topic' : 'profile/4131074/esp8266/13', 'state' : 'False'}
}
templateData = {
    'pins' : pins
}

@main.route("/profile/<string:device>/<board>")
def getDevice(device, board):
    device = Device.query.filter_by(serialNum=device).one()
    return render_template('device.html',device = device, async_mode=socketio.async_mode, **templateData)


@main.route("/profile/<string:device>/<board>/<changePin>/<action>")
def action(board, device, changePin, action):
    changePin = int(changePin)
    devicePin = pins[changePin]['name']
    device = Device.query.filter_by(serialNum=device).one()

    if action == "1" and board == 'esp8266':
        mqttc.publish(pins[changePin]['topic'], "1")
        pins[changePin]['state'] = 'True'
        print("zdr ot leda")

    if action == "0" and board == 'esp8266':
        mqttc.publish(pins[changePin]['topic'], "0")
        pins[changePin]['state'] = 'False'

    return render_template('device.html',device = device, async_mode=socketio.async_mode , **templateData)

