#!/bin/bash

export PROJECT_HOME="/app"
export WORK="/work"
export MYSQL_HOME="/app/mysql"  \


if [ -e ${MYSQL_HOME} ]
then
    echo "${MYSQL_HOME} already exists."
else
    echo "${MYSQL_HOME} does not exists."
    tar xvfz $WORK/mysql.tar.gz
fi

# Start supervisord
echo "Running the run_supervisor!"
supervisord -n
