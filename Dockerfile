FROM openjdk:8-jdk
MAINTAINER Adam Sanchez <a.sanchez75@gmail.com>

ENV FUSEKI_VERSION 3.6.0
ENV FUSEKI_BASE /usr/local/src/apache-jena-fuseki-data
ENV FUSEKI_HOME /usr/local/src/apache-jena-fuseki-$FUSEKI_VERSION

RUN mkdir /usr/local/src/apache-jena-fuseki-data
RUN apt-get update && apt-get install -y wget
RUN cd /usr/local/src && \
    wget http://archive.apache.org/dist/jena/binaries/apache-jena-fuseki-$FUSEKI_VERSION.tar.gz && \
    tar xzf apache-jena-fuseki-$FUSEKI_VERSION.tar.gz

RUN ln -s /usr/local/src/apache-jena-fuseki-$FUSEKI_VERSION/fuseki /etc/init.d/ && \
    update-rc.d fuseki defaults

COPY shiro.ini $FUSEKI_BASE
COPY fuseki-fulltext-config.ttl $FUSEKI_BASE/config.ttl

WORKDIR $FUSEKI_HOME
EXPOSE 3030

COPY init.sh /
RUN chmod u+x /init.sh

CMD ["/init.sh"]

