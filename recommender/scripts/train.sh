#!/bin/sh

LOCKFILE=/tmp/piolock
if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`; then
    echo "training task is already running"
    exit
fi

trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
echo $$ > ${LOCKFILE}

echo "[$(date)] Training and deploying PredictionIO engine\\n"

cd /urengine

pio build --verbose
pio train -- --master spark://sparkmaster:7077 --executor-memory 4G --driver-memory 4G --conf spark.serializer=org.apache.spark.serializer.KryoSerializer
nohup pio deploy -- --executor-memory 4G --driver-memory 4G --total-executor-cores 2 &

rm -f ${LOCKFILE}
