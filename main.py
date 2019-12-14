from flask import Blueprint, render_template, redirect, url_for, request, flash
from flask_login import login_required, current_user
from .models import Device
import paho.mqtt.client as mqtt
from . import db
from . import socketio

main = Blueprint('main', __name__)


@main.route("/profile")
@login_required
def profile():
    return render_template('profile.html',async_mode=socketio.async_mode, **templateData)

@main.route("/profile/add_device", methods=['GET','POST'])
@login_required
def addDevice():
    if request.method == 'POST':
        name = request.form.get('name')
        serialNum = request.form.get('serialNum')

        db.create_all()
        new_device = Device(name=name, serialNum = serialNum)
        current_user.devices.append(new_device)                
        db.session.commit()
        
        return redirect(url_for('main.profile'))

    else:
        return render_template('deviceAdder.html', **templateData)

@main.route("/")
def index():
    return render_template('index.html')

@main.route("/profile/<board>/<changePin>/<action>")
def action(board, changePin, action):
    changePin = int(changePin)
    devicePin = pins[changePin]['name']

    if action == "1" and board == 'esp8266':
        mqttc.publish(pins[changePin]['topic'], "1")
        pins[changePin]['state'] = 'True'
        print("zdr ot leda")

    if action == "0" and board == 'esp8266':
        mqttc.publish(pins[changePin]['topic'], "0")
        pins[changePin]['state'] = 'False'

    templateData = {
        'pins' : pins
    }

    return render_template('profile.html', **templateData)

def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))
    print("zdr")
    client.subscribe("/profile/esp8266/temperature")
    client.subscribe("/profile/esp8266/humidity")
    client.subscribe("/profile/esp8266/light")


def on_message(client, userdata, message):
    print("Received message '" + str(message.payload) + "' on topic '" + message.topic + "' with QoS " + str(message.qos))

    if message.topic == "/profile/esp8266/temperature":
        print("temperature update")
        socketio.emit('dht_temperature', {'data' : message.payload})
   

    if message.topic == "/profile/esp8266/humidity":
        print("humidity update")
        socketio.emit('dht_humidity', {'data' : message.payload})

    if message.topic == "/esp8266/light":
        print("light update")
        socketio.emit('light_sensor', {'data' : message.payload})

mqttc = mqtt.Client()
mqttc.on_connect = on_connect
mqttc.on_message = on_message
mqttc.connect("localhost", 1883, 60)
mqttc.loop_start()

pins = {
    4 : {'name' : 'GPIO 4', 'board' : 'esp8266', 'topic' : '/profile/esp8266/4', 'state' : 'False'},
    5 : {'name' : 'GPIO 5', 'board' : 'esp8266', 'topic' : '/profile/esp8266/5', 'state' : 'False'}
}

templateData = {
    'pins' : pins
}
