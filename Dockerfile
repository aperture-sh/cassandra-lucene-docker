FROM maven:3.6.0-amazoncorretto-8 AS build

ADD . /build
WORKDIR /build

RUN yum -y install git wget
RUN git clone https://github.com/Stratio/cassandra-lucene-index
RUN cd cassandra-lucene-index && git checkout 3.11.3.0

RUN cd cassandra-lucene-index && mvn clean package

FROM cassandra:3.11.3

COPY --from=build /build/plugin/target/cassandra-lucene-index-plugin-3.11.3.0.jar /usr/share/cassandra/lib/cassandra-lucene-index-plugin-3.11.3.0.ja
RUN wget -O /usr/share/cassandra/lib/jts-core-1.14.0.jar http://central.maven.org/maven2/com/vividsolutions/jts-core/1.14.0/jts-core-1.14.0.jar
