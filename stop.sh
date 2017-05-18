#!/bin/bash

echo "stop MySQL container ..."
docker stop soda-mysql

echo "delete MySQL container ..."
docker rm soda-mysql

echo "all done"
