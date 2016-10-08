############################################################
# Dockerfile: CentOS6 & Privoxy
############################################################
FROM centos:latest

MAINTAINER swmacdonald

# Set environment variable
ENV HOME 						/root
ENV TERM 						xterm
ENV LANG 						en_US.UTF-8
ENV LC_ALL						en_US.UTF-8

# Install any updates since intial build
RUN yum -y update && yum clean all

# Install epel release
RUN yum -y install epel-release; yum -y clean all

# Install privoxy
RUN yum -y install privoxy wget; yum -y clean all

ADD run.sh /usr/local/bin/run.sh
RUN /bin/sed -i "s/listen-address  127.0.0.1/listen-address  0.0.0.0/g" /etc/privoxy/config
ADD privoxy-blist.sh /usr/local/bin/privoxy-blist.sh
ADD privoxy-blist.conf /usr/local/bin/privoxy-blist.conf

EXPOSE 8118

CMD ["run.sh"]
