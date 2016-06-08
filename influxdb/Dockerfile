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
    INFLUXDB_HOME="/app/influxdb"  \
    INFLUXDB_LOGS="/app/influxdb/logs" \
    WORK=/work

# Make default directory
RUN mkdir -p $PROJECT_HOME && mkdir -p $WORK && chown -R stigma:stigma $PROJECT_HOME && \
    mkdir -p $PROJECT_HOME/influxdb/logs

# RPM package from file
ADD influxdb.repo /etc/yum.repos.d/influxdb.repo

# Install influxdb, supervisor
RUN yum install -y influxdb supervisor; yum clean all

ADD ./post.sh	$WORK/post.sh
ADD ./supervisord.conf $WORK/supervisord.conf
RUN chmod 755 $WORK/post.sh

# COPY supervisord.conf
COPY ./supervisord.conf /etc/supervisord.conf

# compress Application
RUN cd $WORK && tar cvfz $WORK/influxdb.tar.gz $INFLUXDB_HOME && rm -rf $PROJECT_HOME

EXPOSE 80
EXPOSE 8083
EXPOSE 8086

CMD ["/work/post.sh"]
