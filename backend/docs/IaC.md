# Infrastructure as Code

Se utilizó CloudFormation de AWS para implementar IaC.\
El Stack que se incoporó contempla 7 elementos:
* [AWS::CodeDeploy::**Application**](#AWS::CodeDeploy::Application)
* [AWS::CodeDeploy::**DeploymentGroup**](#AWS::CodeDeploy::DeploymentGroup)
* [AWS::AutoScaling::**AutoScalingGroup**](#AWS::AutoScaling::AutoScalingGroup)
* [AWS::AutoScaling::**LaunchConfiguration**](#AWS::AutoScaling::LaunchConfiguration)
* [AWS::ElasticLoadBalancingV2::**TargetGroup**](#AWS::ElasticLoadBalancingV2::TargetGroup)
* [AWS::ElasticLoadBalancingV2::**Listener**](#AWS::ElasticLoadBalancingV2::Listener)
* [AWS::ElasticLoadBalancingV2::**LoadBalancer**](#AWS::ElasticLoadBalancingV2::LoadBalancer)

Este estack permite replicar la mayoría de la aplicación pero deja de lado algunas partes que pueden ser reutilizadas como lo serían los roles, las imagesId y los perfiles IAM, entre otras cosas. [Esas partes](#Elementos) son requeridas para que funcione el Stack y deben estar creadas para que el Stack se pueda crear.

## AWS::CodeDeploy::Application
```yml
CDA4VK6:
    Type: 'AWS::CodeDeploy::Application'
    Properties:
      ApplicationName: cloudformation
```
## AWS::CodeDeploy::DeploymentGroup
Este elemento crea un Deployment Group que se conecta con el [Auto Scaling Group](#AWS::AutoScaling::AutoScalingGroup) creado más adelante y utiliza una IAM que no pertenece al Stack.
```yml
CDDG1H0QK:
    Type: 'AWS::CodeDeploy::DeploymentGroup'
    Properties:
      ServiceRoleArn: 'arn:aws:iam::556070822500:role/codedeployservicerole'
      AutoScalingGroups:
        - !Ref ASASG4YLTD
      ApplicationName: cloudformation
    DependsOn:
      - CDA4VK6
```

## AWS::AutoScaling::AutoScalingGroup
Este elemento crea un Auto Scaling Group que uiliza una [Launch Configuration](#AWS::AutoScaling::LaunchConfiguration) creada más adelante y tambien requiere de un [Target Group](#AWS::ElasticLoadBalancingV2::TargetGroup) creado más adelante.
```yml
ASASG4YLTD:
    Type: 'AWS::AutoScaling::AutoScalingGroup'
    Properties:
      LaunchConfigurationName: !Ref ASLC42KNR
      MinSize: 1
      MaxSize: 1
      AvailabilityZones:
        - us-east-2a
        - us-east-2b
        - us-east-2c
      TargetGroupARNs:
        - !Ref ELBV2TG39141
```

## AWS::AutoScaling::LaunchConfiguration
Este elemento crea una Launch configuration para el [Auto Scaling Group](#AWS::AutoScaling::AutoScalingGroup) y contiene toda la información necesaria para que este pueda crear instancias. Esta información se saca de elementos externos al Stack. Además en la parte de UserData, contiene lo necesario para que las instancias que se levanten se echen a correr automáticamente.
```yml
ASLC42KNR:
    Type: 'AWS::AutoScaling::LaunchConfiguration'
    Properties:
      ImageId: ami-0f25ac7fdc325cee0
      InstanceType: t2.micro
      KeyName: 16v2-key
      IamInstanceProfile: travis-rol
      UserData: !Base64 
        'Fn::Join':
          - ''
          - - |
              #!/bin/bash
            - |
              pwd=$( aws ecr get-login-password )
            - |
              docker container stop $(docker container ls -aq)
            - >
              docker login -u AWS -p $pwd
              https://556070822500.dkr.ecr.us-east-2.amazonaws.com
            - >
              docker pull
              556070822500.dkr.ecr.us-east-2.amazonaws.com/16arqsisv2
            - >
              docker-compose -f
              /home/ec2-user/aux_arqui_repo/backend/local-docker-compose.yml up
              -d
      SecurityGroups:
        - sg-0484f2ac47190da3d 
```

## AWS::ElasticLoadBalancingV2::TargetGroup
Este elemento crea un target group para el [Auto Scaling Group](#AWS::AutoScaling::AutoScalingGroup).
```yml
ELBV2TG39141:
    Type: 'AWS::ElasticLoadBalancingV2::TargetGroup'
    Properties:
      Protocol: HTTP
      Port: 80
      VpcId: vpc-7a4ae111
```

## AWS::ElasticLoadBalancingV2::Listener
Este elemento crea un Listener que conecta el [Target Group](#AWS::ElasticLoadBalancingV2::TargetGroup) con el [Load Balancer](#AWS::ElasticLoadBalancingV2::LoadBalancer).
```yml
ELBV2L2ZHWN:
    Type: 'AWS::ElasticLoadBalancingV2::Listener'
    Properties:
      DefaultActions:
        - Type: forward
          TargetGroupArn: !Ref ELBV2TG39141
      LoadBalancerArn: !Ref ELBV2LB1HCWG
      Port: 80
      Protocol: HTTP
    DependsOn:
      - ELBV2TG39141
      - ELBV2LB1HCWG
```

## AWS::ElasticLoadBalancingV2::LoadBalancer
Este elemento crea el Load balancer que se conecta con el [Target Group](#AWS::ElasticLoadBalancingV2::TargetGroup) a través de el [Listener](#AWS::ElasticLoadBalancingV2::Listener) para poder distribuir la carga entre las distintas instancias levantadas por el [Auto Scaling Group](#AWS::AutoScaling::AutoScalingGroup).
```yml
ELBV2LB1HCWG:
    Type: 'AWS::ElasticLoadBalancingV2::LoadBalancer'
    Properties:
      SecurityGroups:
        - sg-0484f2ac47190da3d
      Subnets:
        - subnet-c04695ab
        - subnet-81464efb
        - subnet-1352225f
```

## Elementos externos al Stack utilizados:

* Service Role: ``arn:aws:iam::556070822500:role/codedeployservicerole``
* ImageId for EC2 instance: ``ami-0f25ac7fdc325cee0``
* Key: ``16v2-key``
* IamInstanceProfile: ``travis-rol``
* Security Group: `sg-0484f2ac47190da3d`
* VPC: ``vpc-7a4ae111``

## Posibles mejoras
Una posible mejora sería incorporar el sistema de monitoreo al stack, porque actualmente es necesario conectar manualmente le monitoreo a cualquier nuevo ambiente.





