FROM ubuntu:trusty

RUN apt-get update && apt-get install -y wget

RUN wget -qO - http://puppetmaster.georiot.com:8090/binary/keyFile | apt-key add -
RUN echo "deb http://puppetmaster.georiot.com:8090/binary /" > /etc/apt/sources.list.d/georiot.list

RUN apt-get update && \
	apt-get install -y python python-setuptools git && \
        apt-get install -y mono && \
        apt-get install -y curl && \
        apt-get install -y patch && \
        apt-get install -y build-essential && \
	easy_install supervisor && \
        mkdir /var/log/dockreg && \
	mkdir -p /opt/GeoRiot.Service.ConsoleHost/

EXPOSE 8080

CMD []
ENTRYPOINT ["/usr/local/bin/supervisord","-c","/etc/supervisord.conf"]

ADD supervisord.conf /etc/supervisord.conf
ADD dockreg /usr/bin/dockreg

ADD GeoRiot.Service.ConsoleHost/* /opt/GeoRiot.Service.ConsoleHost/

RUN chmod a+x /usr/bin/dockreg
