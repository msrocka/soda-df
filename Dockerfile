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

WORKDIR /data

# download and extract Tomcat to '/opt/tomcat'
RUN curl -O http://mirror.softaculous.com/apache/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz \
	&& mkdir /opt/tomcat \
	&& tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1 \
	&& rm apache-tomcat-8*tar.gz

# TODO: put the MySQL driver to Tomcat


# download and install soda4LCA
# RUN curl -O 
# RUN unzip soda4LCA_3.0.5.zip


# initialize the soda4LCA database
RUN service mysql start \
	&& mysqladmin -u root create soda

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
EXPOSE 8080

# sudo docker run -it --rm -p 80:8080 soda
CMD [ "/opt/tomcat/bin/catalina.sh", "run" ]

