#!/bin/bash
docker-compose -f /home/ec2-user/aux_arqui_repo/backend/local-docker-compose.yml down
docker stop $(docker ps -a -q)