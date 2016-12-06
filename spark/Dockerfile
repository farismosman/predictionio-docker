FROM farismosman/spark

# installing dnsutils -- related to the hack in start.sh
RUN apt-get update && apt-get install -y dnsutils

# config
ADD spark-defaults.conf /opt/spark/conf/spark-defaults.conf

# scripts to start the cluster
ADD start.sh /start.sh
RUN chmod +x  /start.sh

ENV SPARK_MASTER_IP 'piosparkmaster'
