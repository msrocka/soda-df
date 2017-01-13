#soda-df
This project contains a Dockerfile to run a [soda4LCA node](https://bitbucket.org/okusche/soda4lca)
in a [Docker](https://www.docker.com/) container.

## Building the image
Before building the Docker image, you need to download the current version of
soda4LCA, extrat it, and copy the file `soda4LCA_*/bin/Node.war` as `soda.war`
next to the Dockerfile. 

After this you should be able to build the image, e.g. the following command
will build the image with the name `soda`:

```bash
docker build -t soda .
```
