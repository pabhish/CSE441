from flask import Flask
from datetime import datetime
# import pytz

app = Flask(__name__)

def getCurrentDateTime():
   return datetime.now().strftime("%x %X")   # MM/DD/YY hh:mm:ss
   # return datetime.now(tz=pytz.timezone(os.environ.get('TZ'))
   # return datetime.now(tz=pytz.timezone('Asia/Calcutta'))

@app.route("/")
def index():
   return getCurrentDateTime()

if __name__ == "__main__":
   # app.run(host="0.0.0.0", port=8080, ssl_context=('cert/selfsigned.crt', 'cert/selfsigned.key'))
   app.run(host="0.0.0.0", port=8080)
