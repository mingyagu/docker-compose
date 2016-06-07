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
ENV PROJECT_HOME="/WORKSPACE" \
    PROJECT_WORK="/WORKSPACE/work" \
    GRAFANA_HOME="/WORKSPACE/GRAFANA"  \
    GRAFANA_LOGS="/WORKSPACE/GRAFANA/logs"

# Make default directory
RUN mkdir -p $PROJECT_WORK && chown -R stigma:stigma $PROJECT_HOME && \
    mkdir -p $PROJECT_HOME/GRAFANA/logs

# Install grafana, supervisor
ADD ./grafana.repo	/etc/yum.repos.d/grafana.repo
RUN yum install -y grafana supervisor; yum clean all

ADD ./post.sh 	 $PROJECT_WORK/post.sh
ADD ./supervisord.conf	$PROJECT_WORK/supervisord.conf
RUN chmod 755	 $PROJECT_WORK/post.sh

# COPY supervisord.conf
COPY ./supervisord.conf	/etc/supervisord.conf

EXPOSE	3000

CMD ["/WORKSPACE/work/post.sh"]
