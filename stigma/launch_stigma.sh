#!/bin/bash

export STIGMA_WORK="/STIGMA/work"
export STIGMA_HOME="/var/www/stigma2-dev"

# sshd start
#echo $SUSER_PASSWORD | sudo -S /etc/init.d/sshd start
# Extract HTTPD if it does not exists


if [ -e ${STIGMA_HOME} ]
then
    echo "${STIGMA_HOME} already exists."
else
    echo "${STIGMA_HOME} does not exists."

    ## Laravel Setting
    #cd /var/www && composer create-project --prefer-dist laravel/laravel blog "~5.0.0"
    cd /var/www && git clone https://github.com/stigma2/stigma2-dev.git
    #cd /var/www/stigma2-dev && git init . && git remote add origin https://github.com/stigma2/stigma2-dev && git pull origin master
    cd /var/www/stigma2-dev && chmod -R 777 storage && composer install
    #/bin/cp -rf /var/www/stigma2-dev/.env.example /var/www/stigma2-dev/.env
    cd /var/www/stigma2-dev && php artisan key:generate && php artisan migrate && php artisan db:seed
fi


# Application Start - Httpd
/usr/sbin/httpd -D FOREGROUND
