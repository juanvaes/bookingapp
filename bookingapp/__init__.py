from flask import Flask

def create_app():
    app = Flask(__name__)

    @app.route("/index")
    def index():
        return "Hello World, my name is Juan Camilo Valencia"
    return app
