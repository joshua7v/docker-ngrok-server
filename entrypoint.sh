#!/bin/sh

prepare_crt() {
	openssl genrsa -out base.key 2048
	openssl req -new -x509 -nodes -key base.key -days 10000 -subj "/CN=$NGROK_DOMAIN" -out base.pem
	openssl genrsa -out server.key 2048
	openssl req -new -key server.key -subj "/CN=$NGROK_DOMAIN" -out server.csr
	openssl x509 -req -in server.csr -CA base.pem -CAkey base.key -CAcreateserial -days 10000 -out server.crt

	cp base.pem assets/client/tls/ngrokroot.crt
}

build() {
	GOOS=linux GOARCH=amd64 make release-server
	GOOS=darwin GOARCH=amd64 make release-client
}

prepare_crt
build

/opt/ngrok/bin/ngrokd -tlsKey=device.key -tlsCrt=device.crt -domain=$NGROK_DOMAIN -httpAddr=":8081" -httpsAddr=":8082"
