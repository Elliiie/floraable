from flask_login import UserMixin
from . import LoginManager
from . import db
from sqlalchemy.orm import relationship


relationship_table=db.Table('relationship_table', 
                             db.Column('user_id', db.Integer,db.ForeignKey('user.id'), nullable=False),
                             db.Column('device_id',db.Integer,db.ForeignKey('device.id'),nullable=False),
                             db.PrimaryKeyConstraint('user_id', 'device_id') )

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True) # primary keys are required by SQLAlchemy
    email = db.Column(db.String(100), unique=True)
    password = db.Column(db.String(100))
    name = db.Column(db.String(1000))
    devices=db.relationship('Device', secondary=relationship_table, backref='user', uselist=True)  

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

class TemperatureSensorValues(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    deviceId = db.Column(db.Integer, db.ForeignKey('device.id'), nullable=False)
    value = db.Column(db.Float)

class MoistureSensorValues(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    deviceId = db.Column(db.Integer, db.ForeignKey('device.id'), nullable=False)
    value = db.Column(db.Float)

class LightSensorValues(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    deviceId = db.Column(db.Integer, db.ForeignKey('device.id'), nullable=False)
    value = db.Column(db.Float)