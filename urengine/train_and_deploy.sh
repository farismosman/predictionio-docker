#!/bin/sh
set -e

cd /UREngine

echo "${date} Training and deploying PredictionIO engine\\n"

# Train and deploy

pio build --verbose
pio train -- --master spark://piosparkmaster:7077 --executor-memory 4G --driver-memory 4G --conf spark.serializer=org.apache.spark.serializer.KryoSerializer
pio deploy -- --executor-memory 4G --driver-memory 4G --total-executor-cores 2
