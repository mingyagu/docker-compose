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

# RPM package from file
ADD influxdb.repo /etc/yum.repos.d/influxdb.repo

# Install influxdb
RUN yum install -y influxdb; yum clean all

#ADD ./influxdb.conf /etc/influxdb/influxdb.conf
ADD ./start.sh	$STIGMA_WORK/start.sh

RUN chmod 755 $STIGMA_WORK/start.sh

EXPOSE 80
EXPOSE 8083
EXPOSE 8086

CMD ["/bin/bash", "/STIGMA/work/start.sh"]
