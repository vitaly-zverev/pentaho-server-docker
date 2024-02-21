FROM openjdk:11.0.15-jdk-bullseye

MAINTAINER vitaly.zverev@gmail.com
LABEL Pentaho='Server 9.4 ce'

# Init ENV
ENV BISERVER_VERSION 9.4
ENV BISERVER_TAG 9.4.0.0-343
ENV PENTAHO_HOME /opt/pentaho

# Apply JAVA_HOME
ENV PENTAHO_JAVA_HOME $JAVA_HOME
ENV PENTAHO_JAVA_HOME /usr/local/openjdk-11
ENV JAVA_HOME /usr/local/openjdk-11
RUN . /etc/environment \
 export JAVA_HOME

# Install Dependences
RUN apt-get update; apt-get install zip -y; \
apt-get install wget unzip git vim -y; \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

RUN mkdir ${PENTAHO_HOME}; useradd -s /bin/bash -d ${PENTAHO_HOME} pentaho; chown -R pentaho:pentaho ${PENTAHO_HOME};

# Download Pentaho BI Server
# Disable first-time startup prompt
# Disable daemon mode for Tomcat
RUN /usr/bin/wget --progress=dot:giga \
"https://privatefilesbucket-community-edition.s3.us-west-2.amazonaws.com/9.4.0.0-343/ce/server/pentaho-server-ce-9.4.0.0-343.zip" \
-O /tmp/pentaho-server-ce-${BISERVER_TAG}.zip; \
/usr/bin/unzip -q /tmp/pentaho-server-ce-${BISERVER_TAG}.zip -d $PENTAHO_HOME; \
rm -f /tmp/pentaho-server-ce-${BISERVER_TAG}.zip $PENTAHO_HOME/pentaho-server/promptuser.sh; \
sed -i -e 's/\(exec ".*"\) start/\1 run/' $PENTAHO_HOME/pentaho-server/tomcat/bin/startup.sh; \
chmod +x $PENTAHO_HOME/pentaho-server/start-pentaho-debug.sh;

#ADD DB drivers
COPY ./lib/. $PENTAHO_HOME/pentaho-server/tomcat/lib

#COPY ./scripts/. ${PENTAHO_HOME}/pentaho-server/scripts

#Always non-root user
USER pentaho

WORKDIR /opt/pentaho

EXPOSE 8080 8009 8443

CMD ["sh", "/opt/pentaho/pentaho-server/start-pentaho-debug.sh"]
#CMD ["sh", "/opt/pentaho/pentaho-server/start-pentaho.sh"]
#ENTRYPOINT ["sh", "-c", "$PENTAHO_HOME/pentaho-server/scripts/run.sh"]
