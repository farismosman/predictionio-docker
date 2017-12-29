
FROM openjdk:8-jre-slim

# install supervisor
RUN apt-get update && apt-get install -y supervisor wget

# downloading and unpacking Spark 1.6.3 [prebuilt for Hadoop 2.6+ and scala 2.10]
RUN wget "http://d3kbcqa49mib13.cloudfront.net/spark-1.6.3-bin-hadoop2.6.tgz"
RUN tar -xzf "spark-1.6.3-bin-hadoop2.6.tgz"
RUN mv spark-1.6.3-bin-hadoop2.6 /opt/spark
RUN rm -f spark-1.6.3-bin-hadoop2.6.tgz

RUN ln -s /opt/spark /usr/local/spark

ENV SPARK_HOME '/usr/local/spark'

ADD start.sh /start.sh
RUN chmod +x  /start.sh

# clean up
RUN apt-get remove -y wget

# default command: running an interactive spark shell in the local mode
CMD ["/opt/spark/bin/spark-shell", "--master", "local[*]"]
