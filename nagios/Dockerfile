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
ENV PROJECT_HOME="/app" \
    NAGIOS_HOME="/app/nagios"  \
    NAGIOS_LOGS="/app/nagios/logs" \
    WORK=/work

# Make default directory
RUN mkdir -p $PROJECT_HOME && mkdir -p $WORK && chown -R stigma:stigma $PROJECT_HOME && \
    mkdir -p $NAGIOS_HOME/logs

# install Prerequisites
RUN yum install httpd php php-cli gcc glibc glibc-common gd gd-devel net-snmp openssl-devel wget unzip -y

# Create user and group for Nagios to use
RUN useradd nagios
RUN groupadd nagcmd
RUN usermod -a -G nagcmd nagios
RUN usermod -a -G nagcmd apache

ADD ./nagiosInstall.sh	$WORK/nagiosInstall.sh
ADD ./nagiosPlug.sh	$WORK/nagiosPlug.sh
ADD ./post.sh  $WORK/post.sh

RUN chmod 755 $WORK/nagiosInstall.sh $WORK/nagiosPlug.sh $WORK/post.sh

# Install Nagios shall start
RUN $WORK/nagiosInstall.sh

# Creating a password for nagiosadmin
RUN htpasswd -cb /usr/local/nagios/etc/htpasswd.users nagiosadmin qwe123

# Install Nagios Plugins
RUN $WORK/nagiosPlug.sh

# Install supervisor
RUN yum install -y supervisor; yum clean all

ADD ./supervisord.conf	$WORK/supervisord.conf

#COPY supervisord.conf
COPY ./supervisord.conf /etc/supervisord.conf

# compress Application
RUN cd $WORK && tar cvfz $WORK/nagios.tar.gz $NAGIOS_HOME && rm -rf $PROJECT_HOME

EXPOSE 80

CMD ["/work/post.sh"]
