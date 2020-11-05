#!/bin/sh

docker build -t symbiote/php-fpm:7.1 .
docker build -t symbiote/phpfff .
