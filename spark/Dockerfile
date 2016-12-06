FROM ubuntu:16.04

# installing required software
RUN apt-get update && apt-get install -y software-properties-common
RUN apt-add-repository ppa:webupd8team/java -y
RUN apt-get update -y

# automatically agreeing on oracle license agreement that normally pops up while installing java8
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

# installing java and supervisor
RUN apt-get update && apt-get install -y oracle-java8-installer supervisor dnsutils

# downloading and unpacking Spark 1.4.0 [prebuilt for Hadoop 2.6+ and scala 2.10]
RUN wget "http://d3kbcqa49mib13.cloudfront.net/spark-1.6.3-bin-hadoop2.6.tgz"
RUN tar -xzf "spark-1.6.3-bin-hadoop2.6.tgz"
RUN mv spark-1.6.3-bin-hadoop2.6 /opt/spark
RUN rm -f spark-1.6.3-bin-hadoop2.6.tgz
# copy supervisor config files for master and slave nodes
ADD master.conf /opt/spark/conf/master.conf
ADD slave.conf /opt/spark/conf/slave.conf
ADD spark-defaults.conf /opt/spark/conf/spark-defaults.conf

ADD start.sh /start.sh
RUN chmod +x  /start.sh

# exposing port 8080 to access the Spark master UI
EXPOSE 8080
EXPOSE 8081

ENV SPARK_MASTER_IP 'masterspark'

# default command: running an interactive spark shell in the local mode
CMD ["/opt/spark/bin/spark-shell", "--master", "local[*]"]
