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
next to the Dockerfile. You may also want to change the home page and the 
settings in the `soda4LCA.properties` but make sure that you keep the settings
for the data files. Also, make sure that the Tomcat and Connector-J download
links in the Dockerfile work. After this you should be able to build the image:

```bash
cd container
# build the "soda" image
docker build -t soda .
```

## Running the containers
As described above the [startup.sh](./startup.sh) script will create and start
the containers. After you build the image and tested it locally you probably
want to distribute it on a production server. The easiest way to do that is to
export the image to a tar file and upload it to the server:

```bash
docker save soda -o soda-image.tar
``` 

You also want to upload the `startup.sh` and `shutdown.sh` scripts to the server.
If you set up a database upload also the data directory `/opt/soda/datadir` (or
your location if you changed it in the startup.sh script) to the same location
on the server.

The startup.sh script maps the 8080 port to the same port on the docker host.
You may also want to change this to port 80 in the startup script:

```bash
docker run -p 80:8080 ...
```

Then import the image on the server and run the startup script:

```bash
docker load -i soda-image.tar
./startup.sh
```

To connect a shell with a running soda container (e.g. for debugging), do:

```
sudo docker exec -it soda /bin/bash
```
