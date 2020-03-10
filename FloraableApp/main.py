from flask import Blueprint, render_template, redirect, url_for, request, flash, session
from flask_login import login_required, current_user
from .models import Device, User, UserDevice, TemperatureSensorValue, HumiditySensorValue, MoistureSensorValue, LightSensorValue, Plant
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
        plantType = request.form.get('plantType')

        device = Device.query.filter_by(serialNum=serialNum).first()

        devices = Device.query.join(UserDevice).join(User).filter((UserDevice.c.user_id == current_user.id)).all()
        plants = Plant.query.all()
        
        if device:
            
            current_user.device.append(device)
            db.session.commit()
        
        else:
            new_device = Device(name=name, serialNum=serialNum, plantType=plantType)
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


def createRecordsInSensorsTables(deviceId, value, table):
        
    device = Device.query.filter_by(serialNum = deviceId).one()
    print(deviceId)

    if table == "temperature":
        new_temperature_value = TemperatureSensorValue(value=value, device_id=device)
        new_temperature_value.append(device)


def on_connect(client, userdata, flags, rc):
        print("Connected with result code "+str(rc))
        client.subscribe("/profile/+/esp8266/temperature")
        client.subscribe("/profile/+/esp8266/humidity")
        client.subscribe("/profile/+/esp8266/soilMoisture")
        client.subscribe("/profile/+/esp8266/light")

def on_message(client, userdata, message):

    print("Received message '" + str(message.payload) + "' on topic '" + message.topic + "' with QoS " + str(message.qos))

    messageElements = message.topic.split("/")
    print(messageElements)

    topic = messageElements[4]
    deviceId = messageElements[2]

    device = Device.query.filter_by(serialNum=deviceId).one()
    print(device)

    if topic == "temperature":
        print("temperature update")
        socketio.emit('dht_temperature', {'data' : message.payload})
        new_temperature_value = TemperatureSensorValue(value=float(message.payload), device_id=device.id)
        new_temperature_value.append(device)

    if topic == "humidity":
        print("humidity update")
        socketio.emit('dht_humidity', {'data' : message.payload})
        
        
    if topic == "soilMoisture":
        print("soil moisture update")
        socketio.emit('soilMoisture_sensor', {'data' : message.payload})
        new_moisture_value = MoistureSensorValue(value=float(message.payload), device_id=device.id)
        db.session.add(new_moisture_value)
        db.session.commit()

    if topic == "light":
        print("light update")
        socketio.emit('light_sensor', {'data' : message.payload})
        new_light_value = LightSensorValue(value=float(message.payload), device_id=device.id)
        db.session.add(new_light_value)
        db.session.commit()

        
        
mqttc.on_connect = on_connect
mqttc.on_message = on_message
mqttc.connect("localhost", 1883, 60)
mqttc.loop_start()

pins = {
    12 : {'name' : 'LED Strip', 'board' : 'esp8266', 'state' : 'False'},
    13 : {'name' : 'Water pump', 'board' : 'esp8266', 'state' : 'False'}
}
templateData = {
    'pins' : pins
}
@main.route("/profile/<string:device>/<board>", methods=['GET','POST'])
def controllDevice(device, board):
    device = Device.query.filter_by(serialNum=device).one()
    if request.method == 'POST':
        if request.form.get('autopilot'):

            print("hi there")

            plantType = device.plantType
            print(plantType)

            plant = Plant.query.filter_by(name=plantType).first()

            moistureVal = MoistureSensorValue.query.filter_by(device_id=device.id).first()
            print(moistureVal)
            
            if(moistureVal.value < plant.moisture_value):
                topicPump = "profile/" + device.serialNum + "/esp8266/13"
                mqttc.publish(topicPump, "1")
                pins[13]['state'] = 'True'

            lightVal = LightSensorValue.query.filter_by(device_id=device.id).first()

            if(lightVal.value < plant.light_value):
                topicLED = "profile/" + device.serialNum + "/esp8266/12"
                mqttc.publish(topicLED, "1")
                pins[12]['state'] = 'True'
            
        else:
            device.autopilot = False
            topicPump = "profile/" + device.serialNum + "/esp8266/13"
            mqttc.publish(topicPump, "0")
            pins[13]['state'] = 'False'
            topicLED = "profile/" + device.serialNum + "/esp8266/12"
            mqttc.publish(topicLED, "0")
            pins[12]['state'] = 'False'

        print(device.autopilot)

    return render_template('device.html',device = device, async_mode=socketio.async_mode, **templateData)


@main.route("/profile/<string:device>/<board>/<changePin>/<action>")
def manual(board, device, changePin, action):
    changePin = int(changePin)
    devicePin = pins[changePin]['name']

    device = Device.query.filter_by(serialNum=device).first()
    plantType = device.plantType
    print(plantType)

    plant = Plant.query.filter_by(name=plantType).first()
    topic = "profile/" + device.serialNum + "/esp8266/" + str(changePin)

    if action == "1" and board == 'esp8266':
        mqttc.publish(topic, "1")
        pins[changePin]['state'] = 'True'

    if action == "0" and board == 'esp8266':
        mqttc.publish(topic, "0")
        pins[changePin]['state'] = 'False'

    return render_template('device.html',device = device, async_mode=socketio.async_mode , **templateData)

