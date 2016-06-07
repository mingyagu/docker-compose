#!/bin/bash

echo "Running the mysql_config function."
yum -y erase mysql mysql-server
rm -rf /var/lib/mysql/ /etc/my.cnf
yum -y install mysql mysql-server
mysql_install_db
chown -R mysql:mysql /var/lib/mysql
/usr/bin/mysqld_safe & 
sleep 10

echo "Running the start_mysql function."
mysqladmin -uroot -ppassword
sleep 10

