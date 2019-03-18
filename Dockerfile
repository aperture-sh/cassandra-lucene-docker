FROM maven AS build

RUN git clone https://github.com/Stratio/cassandra-lucene-index
RUN git checkout branch-3.11.3

WORKDIR ./cassandra-lucene-index

RUN maven clean package

FROM cassandra:3.11.3

COPY --from=build plugin/target/cassandra-lucene-index-plugin-*.jar /opt/sds
RUN wget -O /opt/sds/jts-core-1.14.0.jar http://central.maven.org/maven2/com/vividsolutions/jts-core/1.14.0/jts-core-1.14.0.jar
