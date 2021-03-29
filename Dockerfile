FROM golang:1.16.2

MAINTAINER "monstrum"

RUN mkdir /code /server /client /client/typescript /client/php

WORKDIR /code

RUN apt-get update && \
    apt-get -y install curl gnupg protobuf-compiler && \
    go get -u github.com/golang/protobuf/proto && \
    go get -u github.com/golang/protobuf/protoc-gen-go && \
    go get -u github.com/favadi/protoc-go-inject-tag && \
    go get -u github.com/grpc-ecosystem/go-grpc-middleware && \
    curl -sL https://deb.nodesource.com/setup_11.x  | bash - && \
    apt-get -y install nodejs && \
    npm install -g ts-protoc-gen && \
    apt-get clean && \
    apt-get remove && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY protoc.sh /code/protoc.sh

ENTRYPOINT ["./protoc.sh"]

CMD ["./proto"]