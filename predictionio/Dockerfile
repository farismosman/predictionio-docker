FROM farismosman/spark

# installing java and supervisor
RUN apt-get update && apt-get install -y rsyslog git openssh-server

RUN mkdir -p /tmp/downloads/pio

RUN git clone "https://github.com/actionml/PredictionIO.git" /tmp/downloads/pio
RUN wget "http://www-us.apache.org/dist/hbase/1.2.4/hbase-1.2.4-bin.tar.gz" -P /tmp/downloads

RUN mkdir /opt/hbase
RUN mkdir /opt/pio
RUN mkdir /opt/zookeeper

RUN tar -xvzf /tmp/downloads/hbase-1.2.4-bin.tar.gz -C /opt/hbase/

RUN cd /tmp/downloads/pio && git checkout master && ./make-distribution.sh
RUN tar -xvzf /tmp/downloads/pio/PredictionIO-0.9.7-aml.tar.gz -C /opt/pio
RUN mv /opt/pio/PredictionIO-0.9.7-aml/* /opt/pio
RUN cp -r /tmp/downloads/pio/sbt /opt/pio/

RUN ln -s /opt/hbase/hbase-1.2.4 /usr/local/hbase
RUN ln -s /opt/pio /usr/local/pio
RUN ln -s /opt/zookeeper /usr/local/zookeeper

# clean up
RUN rm -rf /tmp/*
RUN rm -rf /opt/pio/PredictionIO-0.9.7-aml

ENV ROOT_PASSWD 'sshpasswd'
ENV JAVA_HOME '/usr/lib/jvm/java-8-oracle'
ENV PIO_HOME /usr/local/pio
ENV PATH=${PIO_HOME}/bin:$PATH

# ssh settings
RUN mkdir /var/run/sshd
RUN echo "root:${ROOT_PASSWD}" | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN env > /etc/environment
