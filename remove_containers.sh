#!/bin/sh

docker-compose stop
docker rm moscu-api_webapp_1
docker rm moscu-api_test_db_1
docker rm moscu-api_dev_db_1
