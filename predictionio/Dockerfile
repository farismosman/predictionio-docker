FROM farismosman/spark:1.6.3

RUN mkdir /opt/pio
RUN mkdir -p /tmp/downloads/pio
RUN mkdir -p /usr/local/hbase/conf
RUN mkdir -p /usr/local/hadoop/etc/hadoop

# install git
RUN apt-get update && apt-get install -y git curl

RUN git clone "https://github.com/actionml/PredictionIO.git" /tmp/downloads/pio


RUN cd /tmp/downloads/pio && git checkout master && ./make-distribution.sh
RUN tar -xvzf /tmp/downloads/pio/PredictionIO-0.9.7-aml.tar.gz -C /opt/pio
RUN mv /opt/pio/PredictionIO-0.9.7-aml/* /opt/pio
RUN cp -r /tmp/downloads/pio/sbt /opt/pio/
RUN ln -s /opt/pio /usr/local/pio

# clean up
RUN rm -rf /tmp/downloads
RUN apt-get remove -y supervisor curl
RUN rm -rf /opt/pio/PredictionIO-0.9.7-aml

ENV PIO_HOME /usr/local/pio
ENV PATH=${PIO_HOME}/bin:$PATH
