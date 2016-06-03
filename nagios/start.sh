#!/bin/bash

service httpd start
service nagios start

/usr/local/nagios/bin/nagios -d /usr/local/nagios/etc/nagios.cfg
/usr/local/nagios/bin/nagios --worker /usr/local/nagios/var/rw/nagios.qh
/usr/local/nagios/bin/nagios --worker /usr/local/nagios/var/rw/nagios.qh
/usr/local/nagios/bin/nagios --worker /usr/local/nagios/var/rw/nagios.qh
/usr/local/nagios/bin/nagios --worker /usr/local/nagios/var/rw/nagios.qh
/usr/local/nagios/bin/nagios -d /usr/local/nagios/etc/nagios.cfg

