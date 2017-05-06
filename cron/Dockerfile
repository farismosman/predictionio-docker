FROM python:2.7

EXPOSE 22

ADD requirements.txt /code/requirements.txt
WORKDIR /code

RUN apt-get update && apt-get install -y openssh-server
RUN pip install -r requirements.txt

ADD app.py /code/app.py
ADD run.sh /code/run.sh

RUN chmod +x /code/run.sh

CMD /code/run.sh
