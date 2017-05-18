#!/bin/bash

echo "stop soda container"
docker stop soda

echo "delete soda container ..."
docker rm soda

echo "stop MySQL container ..."
docker stop soda-mysql

echo "delete MySQL container ..."
docker rm soda-mysql

echo "all done"
