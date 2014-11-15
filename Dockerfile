FROM ubuntu:trusty

RUN apt-get update && apt-get install -y wget

RUN wget -qO - http://puppetmaster.georiot.com:8090/binary/keyFile | apt-key add -
RUN echo "deb http://puppetmaster.georiot.com:8090/binary /" > /etc/apt/sources.list.d/georiot.list

RUN apt-get update && \
	apt-get install -y python python-setuptools && \
        apt-get install -y mono=3.8.0-git-tag-09042014 && \
	easy_install supervisor && \
	mkdir /var/log/dockreg

EXPOSE 8080

CMD []
ENTRYPOINT ["/usr/local/bin/supervisord","-c","/etc/supervisord.conf"]

ADD supervisord.conf /etc/supervisord.conf
ADD dockreg /usr/bin/dockreg

ADD GeoRiot.Service.ConsoleHost/ /opt/GeoRiot.Service.ConsoleHost/

RUN chmod a+x /usr/bin/dockreg
