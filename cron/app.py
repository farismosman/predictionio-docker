from flask import Flask
import paramiko
import atexit
import os
from apscheduler.schedulers.background import BackgroundScheduler

app = Flask(__name__)

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())


def ssh_into_pio_host():
    service_name = os.environ['SERVICE_NAME']
    ssh_passwd = os.environ['SSH_PASSWD']

    if ssh.get_transport() is None:
        print 'No transport channel! Logging in ...'
        ssh.connect(service_name, username='root', password=ssh_passwd)
    elif ssh.get_transport().is_active() is False:
        print 'No active connection! Initializing connection ...'
        ssh.connect(service_name, username='root', password=ssh_passwd)


def train_pio_engine():
    ssh_into_pio_host()
    cron_command = os.environ['CRON_COMMAND']

    stdin, stdout, stderr = ssh.exec_command(cron_command)
    print 'stdin: ', stdin.readlines()
    print 'stdout: ', stdout.readlines()
    print 'stderr: ', stderr.readlines()
    ssh.close()


if __name__ == "__main__":
    scheduler = BackgroundScheduler()
    interval_minutes = os.environ['INTERVAL']
    scheduler.add_job(train_pio_engine, 'interval', minutes=int(interval_minutes))
    scheduler.start()
    atexit.register(lambda: scheduler.shutdown())

    app.run(host="0.0.0.0", debug=True)
