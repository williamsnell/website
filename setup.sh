#!/bin/bash

git clone https://github.com/williamsnell/website.git

cd website

apt install docker docker-compose

docker load < services.img
docker-compose up

