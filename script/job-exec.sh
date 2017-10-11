#! /bin/bash

ARG1=$1
ARG2=$2

source prep-env.sh

JOB_QUEUE_ARN="arn:aws:batch:${AWS_REGION}:${AWS_ACCOUNTID}:job-queue/simple-job-queue-${MYENV}"
JOB_DEFINITION_ARN="arn:aws:batch:${AWS_REGION}:${AWS_ACCOUNTID}:job-definition/simple-batch-${MYENV}:1"

for i in `seq 1 100`
do
    aws batch submit-job \
        --job-name "simple-batch-job" \
        --job-queue "${JOB_QUEUE_ARN}" \
        --job-definition "${JOB_DEFINITION_ARN}" \
        --parameters Arg1="${ARG1}",Arg2="${ARG2}${i}"
done

