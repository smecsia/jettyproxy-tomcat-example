FROM ubuntu:14.04

EXPOSE 8080 8778

RUN apt-get update -y -q
RUN apt-get install -y software-properties-common

RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update -y -q
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -y -q oracle-java8-installer unzip curl wget libtcnative-1

ENV TOMCAT_VERSION 8.0.23
ENV DEPLOY_DIR /webapps

# Get and Unpack Tomcat
RUN wget http://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/catalina.tar.gz && tar xzf /tmp/catalina.tar.gz -C /opt && ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && rm /tmp/catalina.tar.gz

# Startup script
RUN chmod +x /opt/apache-tomcat-${TOMCAT_VERSION}/bin/*.sh

# Remove unneeded apps
RUN rm -rf /opt/tomcat/webapps/*

VOLUME ["/opt/tomcat/logs", "/opt/tomcat/work", "/opt/tomcat/temp", "/tmp/hsperfdata_root" ]

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin
ENV DEBIAN_FRONTEND noninteractive
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/usr/lib/x86_64-linux-gnu/

CMD /opt/tomcat/bin/deploy-and-run.sh