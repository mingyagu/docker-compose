FROM centos:6

MAINTAINER heeminChae / version: 1.0

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

# Disable SELinux
#RUN setenforce 0

# install Prerequisites
RUN yum install httpd php php-cli gcc glibc glibc-common gd gd-devel net-snmp openssl-devel wget unzip -y

# Create user and group for Nagios to use
RUN useradd nagios
RUN groupadd nagcmd
RUN usermod -a -G nagcmd nagios
RUN usermod -a -G nagcmd apache

ADD ./nagiosInstall.sh	$STIGMA_WORK/nagiosInstall.sh
ADD ./nagiosPlug.sh	$STIGMA_WORK/nagiosPlug.sh
ADD ./start.sh  $STIGMA_WORK/start.sh

RUN chmod 755 $STIGMA_WORK/nagiosInstall.sh
RUN chmod 755 $STIGMA_WORK/nagiosPlug.sh
RUN chmod 755 $STIGMA_WORK/start.sh

# Install Nagios shall start
RUN $STIGMA_WORK/nagiosInstall.sh

# Creating a password for nagiosadmin
RUN htpasswd -cb /usr/local/nagios/etc/htpasswd.users nagiosadmin qwe123

# Install Nagios Plugins
RUN $STIGMA_WORK/nagiosPlug.sh

EXPOSE 80

CMD ["/bin/bash", "/STIGMA/work/start.sh"]
