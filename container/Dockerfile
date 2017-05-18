FROM ubuntu:16.10


# install curl, Open JDK
RUN set -x \
	&& apt-get update && apt-get install -y \
	curl \
	unzip \
	openjdk-8-jre-headless \
	&& rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
WORKDIR /soda

# download and extract Tomcat to '/opt/tomcat' and remove the admin tools
RUN curl -O http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz \
	&& mkdir /opt/tomcat \
	&& tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1 \
	&& rm apache-tomcat-8*tar.gz \
	&& rm -rf /opt/tomcat/webapps/docs \
	&& rm -rf /opt/tomcat/webapps/examples \
	&& rm -rf /opt/tomcat/webapps/host-manager \
	&& rm -rf /opt/tomcat/webapps/manager \
	&& rm -rf /opt/tomcat/webapps/ROOT

# download and put the MySQL driver into the tomcat libraries
RUN curl -O http://cdn.mysql.com/Downloads/Connector-J/mysql-connector-java-5.1.42.tar.gz \
	&& mkdir connector-j \
	&& tar xvf mysql-connector-java-*.tar.gz -C connector-j --strip-components=1 \
	&& mv connector-j/mysql-connector-*.jar /opt/tomcat/lib \
	&& rm -rf connector-j \
	&& rm mysql-connector-java-*.tar.gz

# copy the webapp
COPY Node.war /opt/tomcat/webapps
RUN cp /opt/tomcat/webapps/Node.war /opt/tomcat/webapps/ROOT.war \
    && rm /opt/tomcat/webapps/Node.war

# copy configuration files
COPY server.xml /opt/tomcat/conf
COPY soda4LCA.properties /opt/tomcat/conf

# adding the startup script
COPY start.sh /soda
RUN chmod +x start.sh

EXPOSE 8080

# sudo docker run -it --rm -p 80:8080 soda
CMD [ "/soda/start.sh" ]
