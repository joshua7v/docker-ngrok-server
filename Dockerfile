FROM ubuntu:15.04

MAINTAINER Joshua <joshua7v@hotmail.com>

ENV NGROK_DOMAIN "ngrok.sigmastudio.me"

WORKDIR /opt
RUN apt-get update && apt-get install -y git vim build-essential wget
RUN git clone https://github.com/inconshreveable/ngrok
RUN wget http://www.golangtc.com/static/go/1.4.2/go1.4.2.linux-amd64.tar.gz
RUN tar -zxvf go1.4.2.linux-amd64.tar.gz -C /usr/local/
RUN cp /usr/local/go/bin/* /usr/bin/

WORKDIR /usr/local/go/src
RUN GOOS=darwin GOARCH=amd64 ./make.bash

WORKDIR /opt/ngrok
COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh
ENTRYPOINT ["/sbin/entrypoint.sh"]

VOLUME /opt/ngrok

EXPOSE 4443
