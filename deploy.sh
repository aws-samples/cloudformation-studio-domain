#!/usr/bin/env bash

if [ $# -lt 2 ]; then
  echo "Usage: ./deploy.sh <VpcId>  <SubnetIds seperated by comma>"
  exit 1
fi

rm -rf domain_function.zip
zip -rq domain_function.zip domain_function.py cfnresponse.py

rm -rf UserProfile-function.zip
zip -rq UserProfile-function.zip UserProfile-function.py cfnresponse.py

#rm -rf cfnResponse-layer.zip
#zip -rq cfnResponse-layer.zip cfnresponse.py


export AWS_REGION=${AWS_DEFAULT_REGION}
export AWS_ACCOUNT=$(aws sts get-caller-identity --output text --query Account)
export VPCID=$1
export SUBNET_IDS=$2

export DEPLOYMENT_BUCKET="sagemaker-studio-domain-$AWS_ACCOUNT"
#Create S3 bucket for Lambda Deployment
if aws s3 ls $DEPLOYMENT_BUCKET 2>&1 | grep -q 'NoSuchBucket'; then
        echo "Creating S3 bucket $DEPLOYMENT_BUCKET for Lambda Deployment"

        if [ "$AWS_REGION" != "us-east-1" ]; then
                aws s3api create-bucket --bucket $DEPLOYMENT_BUCKET --region $AWS_REGION --create-bucket-configuration LocationConstraint=$AWS_REGION
        else
                aws s3api create-bucket --bucket $DEPLOYMENT_BUCKET --region $AWS_REGION
        fi
        aws s3api put-bucket-versioning --bucket $DEPLOYMENT_BUCKET --versioning-configuration Status=Enabled
        echo "Uploading the Lambda layer"

        mkdir -p package/python/lib/python3.8/site-packages
        cd package
        # Install the required libraries
        pip3 install urllib3 --target python/lib/python3.8/site-packages
        zip -r urllib3.zip python
        aws s3 cp urllib3.zip s3://${DEPLOYMENT_BUCKET}/
        cd ..
        rm -rf package
else
        echo "S3 bucket $DEPLOYMENT_BUCKET for Lambda Deployment already exists."
fi

aws s3 cp domain_function.zip s3://${DEPLOYMENT_BUCKET}/
aws s3 cp UserProfile-function.zip s3://${DEPLOYMENT_BUCKET}/
aws s3 cp cfnResponse-layer.zip s3://${DEPLOYMENT_BUCKET}/

rm -rf function.zip
LATEST_LAMBDA_KEY=$(aws s3api list-object-versions --bucket $DEPLOYMENT_BUCKET --prefix function.zip --query 'Versions[0].VersionId')

aws cloudformation deploy \
        --stack-name studio-domain-stack3 \
        --template-file sagemaker_studio_template.yaml  \
        --capabilities CAPABILITY_NAMED_IAM \
        --parameter-overrides S3Bucket=$DEPLOYMENT_BUCKET S3ObjectVersion=$LATEST_LAMBDA_KEY VPCId=$VPCID SubnetIds=$SUBNET_IDS
