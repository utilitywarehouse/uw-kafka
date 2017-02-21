FROM registry.uw.systems/base_images/uw-alpine-java:v8

RUN mkdir -p /opt/kafka
WORKDIR /opt/kafka

RUN apk add --no-cache wget ca-certificates bash
RUN wget http://apache.mirror.anlx.net/kafka/0.10.1.1/kafka_2.11-0.10.1.1.tgz
RUN md5sum kafka_2.11-0.10.1.1.tgz
RUN tar -zxvf kafka_2.11-0.10.1.1.tgz --strip 1
RUN rm kafka_2.11-0.10.1.1.tgz

WORKDIR /opt/kafka/bin

CMD ["./kafka-server-start.sh", "../config/server.properties"]
