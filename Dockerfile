FROM maven AS build

ADD . /build
WORKDIR /build

RUN git clone https://github.com/Stratio/cassandra-lucene-index
RUN cd cassandra-lucene-index && git checkout 3.11.3.0

RUN mvn clean package

FROM cassandra:3.11.3

COPY --from=build /build/plugin/target/cassandra-lucene-index-plugin-*.jar /opt/sds/
RUN wget -O /opt/sds/jts-core-1.14.0.jar http://central.maven.org/maven2/com/vividsolutions/jts-core/1.14.0/jts-core-1.14.0.jar
