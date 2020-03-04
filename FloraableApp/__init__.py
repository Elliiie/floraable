from flask import Flask
from flask_login import LoginManager 
from flask_sqlalchemy import SQLAlchemy
from flask_socketio import SocketIO, emit
from flask_admin import Admin, BaseView, expose
from flask_admin.contrib.sqla import ModelView
from flask_migrate import Migrate

db = SQLAlchemy()
socketio = SocketIO()

class MyView(BaseView):
    @expose('/')
    def index(self):
        return self.render('admin.html')

def create_app():
    app = Flask(__name__)
    db.init_app(app)
    migrate = Migrate(app, db)
    app.config['SECRET_KEY'] = 'fok'
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.sqlite'

    admin = Admin(app)
    admin.add_view(MyView(name='Hello'))
    from .models import User
    admin.add_view(ModelView(User, db.session))
    from .models import Device
    admin.add_view(ModelView(Device, db.session))
    from .models import TemperatureSensorValue
    admin.add_view(ModelView(TemperatureSensorValue, db.session))
    from .models import HumiditySensorValue
    admin.add_view(ModelView(HumiditySensorValue, db.session))
    from .models import MoistureSensorValue
    admin.add_view(ModelView(MoistureSensorValue, db.session))
    from .models import LightSensorValue
    admin.add_view(ModelView(LightSensorValue, db.session))
    from .models import Plant
    admin.add_view(ModelView(Plant, db.session))

    socketio.init_app(app, async_mode='threading')

    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.init_app(app)

    from .models import User

    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))

    from .auth import auth as auth_blueprint
    app.register_blueprint(auth_blueprint)

    from .main import main as main_blueprint
    app.register_blueprint(main_blueprint)

    return app

