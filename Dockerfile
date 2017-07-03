FROM registry.uw.systems/base_images/uw-alpine-java:v8

RUN mkdir -p /opt/kafka
WORKDIR /opt/kafka

RUN apk add --no-cache wget ca-certificates bash
RUN wget http://apache.mirror.anlx.net/kafka/0.11.0.0/kafka_2.12-0.11.0.0.tgz 
RUN md5sum kafka_2.12-0.11.0.0.tgz
RUN tar -zxvf kafka_2.12-0.11.0.0.tgz --strip 1
RUN rm kafka_2.12-0.11.0.0.tgz

WORKDIR /opt/kafka/bin

CMD ["./kafka-server-start.sh", "../config/server.properties"]
