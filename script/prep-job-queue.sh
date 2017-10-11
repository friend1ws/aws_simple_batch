#! /bin/bash

source prep-env.sh

COMPUTE_ENV_ARN="arn:aws:batch:${AWS_REGION}:${AWS_ACCOUNTID}:compute-environment/simple-compute-environment-${MYENV}"
JOB_QUEUE_NAME=simple-job-queue-${MYENV}

aws batch create-job-queue \
  --job-queue-name ${JOB_QUEUE_NAME} \
  --priority 1 \
  --compute-environment-order order=1,computeEnvironment=${COMPUTE_ENV_ARN}

