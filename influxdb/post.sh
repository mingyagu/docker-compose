#!/bin/bash

export PROJECT_HOME="/app"
export WORK="/work"
export INFLUXDB_HOME="/app/influxdb"

if [ -e ${INFLUXDB_HOME} ]
then
    echo "${INFLUXDB_HOME} already exists."
else
    echo "${INFLUXDB_HOME} does not exists."
    tar xvfz $WORK/influxdb.tar.gz
fi

# Start supervisord
echo "Running the run_supervisor!"
supervisord -n

