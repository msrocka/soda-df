# soda-df
This project contains a Dockerfile and some scripts to run a 
[soda4LCA node](https://bitbucket.org/okusche/soda4lca) in a 
[Docker](https://www.docker.com/) container. The soda4LCA container contains
a JVM and a Tomcat with the soda4LCA application. It is then linked to a MySQL
container:

```
+------+            +-------+
| soda | -- 3306 -- | MySQL |
+------+            +-------+
```

The [startup.sh](./startup.sh) script creates and links the containers
`soda-mysql` (the MySQL container) and `soda` (the container with soda4LCA).
Per default, the data are stored in the folder `/opt/soda/datadir` in the docker
host but this can be configured in the script. This is the folder that you want
to backup regularly. The folder `/opt/soda/datadir/mysql` will contain the MySQL
datbase and the folder `/opt/soda/datadir/soda` the external files of the
soda4LCA application.

The script ['shutdown.sh'](./shutdown.sh) stops and deletes the containers. 
If you just want to restart a container, use the respective docker command, e.g.:

```bash
# restart the soda container:
docker restart soda
```

## Building the image
Before building the Docker image, you need to download the current version of
soda4LCA, extrat it, and copy the file `soda4LCA_*/bin/Node.war` as `Node.war`
next to the Dockerfile. You may also want to change the settings in the
`soda4LCA.properties` but make sure that you keep the settings for the data
files. Also, make sure that the Tomcat and Connector-J download links in the 
Dockerfile work. After this you should be able to build the image:

```bash
cd container
# build the "soda" image
docker build -t soda .
```

## Running the containers
As described above the [startup.sh](./startup.sh) script will create and start
the containers. 

The container contains a MySQL and Tomcat server that are started via the
default command. The Tomcat port 8080 is exposed and can be mapped to a port
of the host, e.g. to port 80:

```bash
sudo docker run -d -p 80:8080 soda
```

(use the options -it and --rm instead of -d for testing the container 
interactively)


sudo docker exec -it soda /bin/bash