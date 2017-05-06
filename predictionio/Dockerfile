FROM farismosman/spark:1.6.3

RUN mkdir -p /tmp/downloads/pio

# install git
RUN apt-get update && apt-get install -y git rsyslog

RUN git clone "https://github.com/actionml/PredictionIO.git" /tmp/downloads/pio

RUN mkdir /opt/pio

RUN cd /tmp/downloads/pio && git checkout master && ./make-distribution.sh
RUN tar -xvzf /tmp/downloads/pio/PredictionIO-0.9.7-aml.tar.gz -C /opt/pio
RUN mv /opt/pio/PredictionIO-0.9.7-aml/* /opt/pio
RUN cp -r /tmp/downloads/pio/sbt /opt/pio/

RUN ln -s /opt/pio /usr/local/pio

# clean up
RUN apt-get remove -y supervisor
RUN rm -rf /tmp
RUN rm -rf /opt/pio/PredictionIO-0.9.7-aml
RUN add-apt-repository --remove ppa:webupd8team/java -y
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PIO_HOME /usr/local/pio
ENV PATH=${PIO_HOME}/bin:$PATH
RUN env > /etc/environment
