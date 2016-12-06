FROM farismosman/predictionio

# create a directory for the engine
RUN mkdir -p /UREngine

ENV ACCESS_KEY 'vIHVuaXZlcnNhbCByZWNvbW1lbmRlciBidWlsdCBieSBmYXJpcyBvbiBkb2NrZXI'

WORKDIR /UREngine

RUN git clone https://github.com/actionml/template-scala-parallel-universal-recommendation.git .
RUN git checkout v0.3.0

# Add and required config
ADD pio-stop-all ${PIO_HOME}/bin/pio-stop-all
RUN chmod +x ${PIO_HOME}/bin/pio-stop-all

ADD pio-start-all ${PIO_HOME}/bin/pio-start-all
RUN chmod +x ${PIO_HOME}/bin/pio-start-all

ADD pio-env.sh ${PIO_HOME}/conf/pio-env.sh
RUN chmod +x ${PIO_HOME}/conf/pio-env.sh

ADD engine.json /UREngine/engine.json
ADD hbase-site.xml /opt/hbase/hbase-1.2.4/conf/hbase-site.xml

RUN pio build --verbose; exit 0

# Add start up and training scripts
ADD run.sh /run.sh
ADD train_and_deploy.sh /UREngine/train_and_deploy.sh

RUN chmod +x /run.sh
RUN chmod +x /UREngine/train_and_deploy.sh


EXPOSE 2181
EXPOSE 8000
EXPOSE 7070
EXPOSE 22

CMD /run.sh
