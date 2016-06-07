#!/bin/bash

cd $PROJECT_WORK/nagios-plugins-2.1.1
./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
make all
make install

