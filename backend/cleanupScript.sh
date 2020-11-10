#!/bin/bash
if [ -d /home/ec2-user/aux_arqui_repo/backend ]; then
    rm -rf /home/ec2-user/aux_arqui_repo/backend
fi
mkdir -vp /home/ec2-user/aux_arqui_repo/backend