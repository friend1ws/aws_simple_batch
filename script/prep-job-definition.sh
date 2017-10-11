#! /bin/bash

source prep-env.sh

JOB_DEFINITION_NAME="simple-batch-${MYENV}"
IMAGE="${AWS_ACCOUNTID}.dkr.ecr.${AWS_REGION}.amazonaws.com/simple-batch"
ECSTASKROLE="arn:aws:iam::${AWS_ACCOUNTID}:role/AmazonECSTaskS3FullAccess"

CONRAINER_PROPS_FILE="job-definition.spec.json"



cat << EOF > ${CONRAINER_PROPS_FILE}
{
  "image": "${IMAGE}",
  "command": ["Ref::Arg1", "Ref::Arg2"],
  "vcpus": 1,
  "memory": 500,
  "jobRoleArn": "${ECSTASKROLE}"
}
EOF
cat ${CONRAINER_PROPS_FILE}


aws batch register-job-definition \
  --job-definition-name ${JOB_DEFINITION_NAME} \
  --type container \
  --container-properties file://${CONRAINER_PROPS_FILE} \
  --parameters Arg1="Hello",Arg2="s3://simple-batch" \

