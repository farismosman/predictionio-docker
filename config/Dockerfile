FROM alpine

RUN mkdir -p /etc/config

RUN mkdir -p /tmp/spark

ADD spark/* /tmp/spark/

ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
