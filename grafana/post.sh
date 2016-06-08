#!/bin/bash

export PROJECT_HOME="/app"
export WORK="/work"
export GRAFANA_HOME="/app/grafana"


if [ -e ${GRAFANA_HOME} ]
then
    echo "${GRAFANA_HOME} already exists."
else
    echo "${GRAFANA_HOME} does not exists."
    tar xvfz $WORK/grafana.tar.gz
fi

# Start supervisord
echo "Running the run_supervisor!"
supervisord -n
