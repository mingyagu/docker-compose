#!/bin/bash

echo "Nagios Plugins Install"

cd $NAGIOS_HOME
cd nagios-plugins-2.1.1
./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
make all
make install

