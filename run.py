from __init__  import create_app, db, socketio

with app.app_context():
    app = create_app()
db.create_all()
if __name__ == '__main__':
    socketio.run(host = '127.0.0.1', port = 5000, debug = True)