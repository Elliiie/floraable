from flask_login import UserMixin
from . import LoginManager
from . import db
from sqlalchemy.orm import relationship


UserDevice=db.Table('UserDevice', 
    db.Column('user_id', db.Integer,db.ForeignKey('user.id'), nullable=False),
    db.Column('device_id',db.Integer,db.ForeignKey('device.id'),nullable=False),
    db.PrimaryKeyConstraint('user_id', 'device_id') 
    )
    

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True) # primary keys are required by SQLAlchemy
    email = db.Column(db.String(100), unique=True)
    password = db.Column(db.String(100))
    name = db.Column(db.String(1000))
    device = db.relationship('Device', secondary = UserDevice, backref = 'users')

    def is_authenticated(self):
        return True

    def is_active(self):
        return True

    def is_anonymous(self):
        return False

    def get_id(self):
        return self.id

    def __unicode__(self):
        return self.username

class Device(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(1000))
    serialNum = db.Column(db.String(100))
    temp_value = db.relationship('TemperatureSensorValue', backref = 'device')
    humid_value = db.relationship('HumiditySensorValue', backref = 'device')
    moisture_value = db.relationship('MoistureSensorValue', backref = 'device')
    light_value = db.relationship('LightSensorValue', backref = 'device')


class TemperatureSensorValue(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    value = db.Column(db.Float)
    device_id = db.Column(db.Integer, db.ForeignKey('device.id'))

class HumiditySensorValue(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    value = db.Column(db.Float)
    device_id = db.Column(db.Integer, db.ForeignKey('device.id'))

class MoistureSensorValue(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    value = db.Column(db.Float)
    device_id = db.Column(db.Integer, db.ForeignKey('device.id'))


class LightSensorValue(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    value = db.Column(db.Float)
    device_id = db.Column(db.Integer, db.ForeignKey('device.id'))
