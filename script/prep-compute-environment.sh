#! /bin/bash

source prep-env.sh

SERVICEROLE="arn:aws:iam::${AWS_ACCOUNTID}:role/service-role/AWSBatchServiceRole"
INSTANCEROLE="arn:aws:iam::${AWS_ACCOUNTID}:instance-profile/ecsInstanceRole"
COMPUTE_ENV_NAME="simple-compute-environment-${MYENV}"

cat << EOF > compute-environment.spec.json
{
    "computeEnvironmentName": "${COMPUTE_ENV_NAME}",
    "type": "MANAGED", 
    "state": "ENABLED", 
    "computeResources": {
        "type": "EC2", 
        "minvCpus": 0, 
        "maxvCpus": 256, 
        "desiredvCpus": 0, 
        "instanceTypes": ["optimal"],
        "subnets": ["${SUBNET1}", "${SUBNET2}"],
        "securityGroupIds": ["${SECURITYGROUPID}"],
        "instanceRole": "${INSTANCEROLE}" 
    }, 
    "serviceRole": "${SERVICEROLE}"
}
EOF

# Creates the compute environment
aws batch create-compute-environment --cli-input-json file://compute-environment.spec.json

