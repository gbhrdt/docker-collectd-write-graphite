FROM    debian:latest

ENV     DEBIAN_FRONTEND noninteractive

RUN     apt-get -y update
RUN     apt-get -y install collectd curl python-pip libpython2.7 python-setuptools git

# add a fake mtab for host disk stats
ADD     etc_mtab /etc/mtab

ADD     collectd.conf.tpl /etc/collectd/collectd.conf.tpl

RUN	pip install envtpl wheel
RUN cd /opt && git clone https://github.com/lebauce/docker-collectd-plugin.git && cd docker-collectd-plugin
RUN pip install -r /opt/docker-collectd-plugin/requirements.txt

ADD     start_container /usr/bin/start_container
RUN     chmod +x /usr/bin/start_container
CMD     start_container
