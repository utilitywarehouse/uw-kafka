FROM registry.uw.systems/base_images/uw-alpine-java:v8

RUN apk add --no-cache wget ca-certificates openssl bash
RUN wget http://apache.mirror.anlx.net/kafka/0.10.1.1/kafka_2.11-0.10.1.1.tgz
RUN md5sum kafka_2.11-0.10.1.1.tgz
RUN tar -zxvf kafka_2.11-0.10.1.1.tgz

RUN rm -rf kafka_2.11-0.10.1.1/config/*
WORKDIR kafka_2.11-0.10.1.1

ENTRYPOINT bin/kafka-server-start.sh config/server.properties
