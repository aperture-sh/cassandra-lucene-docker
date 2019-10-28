FROM maven:3.6.0-amazoncorretto-8 AS build

MAINTAINER Florian Zouhar <zouhar@marauder.io>

ADD . /build
WORKDIR /build

RUN yum -y install git wget
RUN git clone https://github.com/aperture-sh/cassandra-lucene-index 
RUN cd cassandra-lucene-index && git checkout 3.11.3.0

RUN cd cassandra-lucene-index && mvn clean package

FROM cassandra:3.11.3

RUN apt-get update
RUN apt-get -yq install wget

COPY --from=build /build/cassandra-lucene-index/plugin/target/cassandra-lucene-index-plugin-3.11.3.0.jar /usr/share/cassandra/lib/cassandra-lucene-index-plugin-3.11.3.0.jar
RUN wget -O /usr/share/cassandra/lib/jts-core-1.14.0.jar http://central.maven.org/maven2/com/vividsolutions/jts-core/1.14.0/jts-core-1.14.0.jar
