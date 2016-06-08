FROM centos:6

MAINTAINER Seongtaeyang / version: 1.0

# Add Default User Account : stigma / Change Password : root, stigma
RUN groupadd -g 500 -r stigma && useradd -u 500 -r -m -g stigma stigma && \
        echo "stigma:S2curity" | chpasswd && \
        echo "root:Su2crity" | chpasswd

# Install default package
RUN yum -y install tuned tune-util vim bzip2 gzip unzip tar git wget curl hostname sysvinit-tools util-linux net-tools epel-release openssh* sudo yum-utils

# sudo stigma sshd
RUN echo stigma ALL=/etc/init.d/sshd >> /etc/sudoers
RUN sed -i 's/Defaults    requiretty/\#Defaults    requiretty/g' /etc/sudoers

# TimeZone Change : KST
RUN mv /etc/localtime /etc/localtime.bak && \
        ln -s /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# Set Env
ENV STIGMA_HOME="/STIGMA" \
    STIGMA_WORK="/STIGMA/work"

# Make default directory
RUN mkdir -p $STIGMA_WORK && chown -R stigma:stigma /STIGMA

# Install SW Packages
RUN yum -y install http://rpms.famillecollet.com/enterprise/remi-release-6.rpm && \
    yum-config-manager --enable remi-php56,remi

# Install Apache, PHP
RUN yum -y install httpd mysql-server php php-gd php-mysql php-mcrypt php-mbstring php-pdo php-xml php-fpm

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

# Create Laravel Project
# RUN cd /var/www && composer create-project --prefer-dist laravel/laravel stigma2-dev "~5.0.0"

# Config file copy
COPY launch_stigma.sh $STIGMA_WORK
COPY httpd-vhosts.conf /etc/httpd/conf.d/

# Change owner and access permission
RUN chmod 755 $STIGMA_WORK/launch_stigma.sh && \
chown stigma:stigma $STIGMA_WORK/launch_stigma.sh

#USER 500

# stigma Env
ENV stigma_PASSWORD="S2curity"

EXPOSE 22
EXPOSE 80

# Start Container
CMD ["/STIGMA/work/launch_stigma.sh"]
