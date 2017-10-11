#! /bin/bash

INPUT=$1
OUTPUT=$2

aws configure list

echo "Check input parameter"
echo $INPUT
echo $OUTPUT

echo $INPUT > tmp.txt

aws s3 cp tmp.txt $OUTPUT

rm -rf tmp.txt
