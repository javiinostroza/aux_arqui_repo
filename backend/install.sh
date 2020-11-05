#!/bin/bash

pwd=$( aws ecr get-login-password )
docker container stop $(docker container ls -aq)
docker login -u AWS -p $pwd https://556070822500.dkr.ecr.us-east-2.amazonaws.com
docker pull 556070822500.dkr.ecr.us-east-2.amazonaws.com/16arqsisv2