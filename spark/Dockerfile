
FROM openjdk:8-jdk-slim

RUN apt-get update && apt-get install -y supervisor wget

RUN wget "http://d3kbcqa49mib13.cloudfront.net/spark-1.6.3-bin-hadoop2.6.tgz"
RUN tar -xzf "spark-1.6.3-bin-hadoop2.6.tgz"
RUN mv spark-1.6.3-bin-hadoop2.6 /opt/spark
RUN rm -f spark-1.6.3-bin-hadoop2.6.tgz

RUN ln -s /opt/spark /usr/local/spark

ENV SPARK_HOME '/usr/local/spark'

COPY scripts/start.sh /start.sh
COPY scripts/cleanup.sh /cleanup.sh
COPY config/*.conf /opt/spark/conf/

RUN chmod +x /cleanup.sh
RUN chmod +x  /start.sh

RUN apt-get remove -y wget

CMD ["/usr/local/spark/bin/spark-shell", "--master", "local[*]"]
