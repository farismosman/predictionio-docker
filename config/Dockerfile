FROM alpine

RUN mkdir -p /etc/config

RUN mkdir -p /tmp/hadoop
RUN mkdir -p /tmp/hbase
RUN mkdir -p /tmp/predictionio

ADD hadoop/* /tmp/hadoop/
ADD hbase/* /tmp/hbase/
ADD predictionio/* /tmp/predictionio/

ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
