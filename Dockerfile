FROM ubuntu:14.04

MAINTAINER Joshua <joshua7v@hotmail.com>

ENV NGROK_DOMAIN "ngrok.sigmastudio.me"

RUN apt-get update && apt-get install -y git vim build-essential wget
RUN git clone https://github.com/inconshreveable/ngrok
RUN wget http://www.golangtc.com/static/go/1.4.2/go1.4.2.linux-amd64.tar.gz
RUN tar -zxvf go1.4.2.linux-amd64.tar.gz -C /usr/local/
RUN cp /usr/local/go/bin/* /usr/bin/

WORKDIR /usr/local/go/src
RUN GOOS=darwin GOARCH=amd64 ./make.bash

ADD entrypoint.sh /
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

VOLUME /ngrok/bin

EXPOSE 4443
