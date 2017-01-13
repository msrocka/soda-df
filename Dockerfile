FROM ubuntu:16.10

# for MySQL installation without password prompt
ENV DEBIAN_FRONTEND noninteractive

# install curl, Open JDK, and MySQL
RUN set -x \
	&& apt-get update && apt-get install -y \
	curl \
	unzip \
	openjdk-8-jre-headless \
	mysql-server \
	mysql-client \
	libmysqlclient-dev \
	&& rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
WORKDIR /soda

# download and extract Tomcat to '/opt/tomcat'
RUN curl -O http://mirror.softaculous.com/apache/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz \
	&& mkdir /opt/tomcat \
	&& tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1 \
	&& rm apache-tomcat-8*tar.gz

# copy the webapp and configuration files
COPY soda.war /opt/tomcat/webapps
COPY server.xml /opt/tomcat/conf
COPY soda4LCA.properties /opt/tomcat/conf

# download and put the MySQL driver into the tomcat libraries
RUN curl -O http://cdn.mysql.com/Downloads/Connector-J/mysql-connector-java-5.1.40.tar.gz \
	&& mkdir connector-j \
	&& tar xvf mysql-connector-java-*.tar.gz -C connector-j --strip-components=1 \
	&& mv connector-j/mysql-connector-*.jar /opt/tomcat/lib \
	&& rm -rf connector-j \
	&& rm mysql-connector-java-*.tar.gz

# initialize the soda4LCA database
RUN service mysql start \
	&& mysqladmin -u root create soda

EXPOSE 8080

# sudo docker run -it --rm -p 80:8080 soda
CMD [ "/opt/tomcat/bin/catalina.sh", "run" ]

