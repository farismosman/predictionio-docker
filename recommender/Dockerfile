FROM farismosman/predictionio:0.9.7

RUN mkdir -p /urengine

WORKDIR /urengine

RUN git clone https://github.com/actionml/template-scala-parallel-universal-recommendation.git .
RUN git checkout v0.3.0

RUN pio build --verbose; exit 0

COPY scripts/run.sh /run.sh
COPY scripts/train.sh /train.sh
COPY config/engine.json /urengine/engine.json

RUN chmod +x /run.sh
RUN chmod +x /train.sh

RUN apt-get -y remove git && apt-get -y autoremove
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD "/run.sh"
