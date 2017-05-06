
FROM ubuntu:16.04

# installing required software
RUN apt-get update && apt-get install -y software-properties-common
RUN apt-add-repository ppa:webupd8team/java -y
RUN apt-get update -y

# automatically agreeing on oracle license agreement that normally pops up while installing java8
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

# installing java and supervisor
RUN apt-get update && apt-get install -y oracle-java8-installer supervisor openssh-server

# downloading and unpacking Spark 1.4.0 [prebuilt for Hadoop 2.6+ and scala 2.10]
RUN wget "http://d3kbcqa49mib13.cloudfront.net/spark-1.6.3-bin-hadoop2.6.tgz"
RUN tar -xzf "spark-1.6.3-bin-hadoop2.6.tgz"
RUN mv spark-1.6.3-bin-hadoop2.6 /opt/spark
RUN rm -f spark-1.6.3-bin-hadoop2.6.tgz

RUN ln -s /opt/spark /usr/local/spark

ADD start.sh /start.sh
RUN chmod +x  /start.sh

# exposing ports to access the Spark master UI
EXPOSE 8080 7077 8888 8081 4040 7001 7002 7003 7004 7005 7006

# ssh settings
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

ENV JAVA_HOME '/usr/lib/jvm/java-8-oracle'
ENV SPARK_HOME '/usr/local/spark'

RUN env > /etc/environment

# default command: running an interactive spark shell in the local mode
CMD ["/opt/spark/bin/spark-shell", "--master", "local[*]"]
