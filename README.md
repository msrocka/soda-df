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

The [start.sh](./start.sh) 

## Building the image
Before building the Docker image, you need to download the current version of
soda4LCA, extrat it, and copy the file `soda4LCA_*/bin/Node.war` as `soda.war`
next to the Dockerfile. You may also want to change the settings in the
`soda4LCA.properties`.

After this you should be able to build the image, e.g. the following command
will build the image with the name `soda`:

```bash
docker build -t soda .
```

## Running the container
The container contains a MySQL and Tomcat server that are started via the
default command. The Tomcat port 8080 is exposed and can be mapped to a port
of the host, e.g. to port 80:

```bash
sudo docker run -d -p 80:8080 soda
```

(use the options -it and --rm instead of -d for testing the container 
interactively)
