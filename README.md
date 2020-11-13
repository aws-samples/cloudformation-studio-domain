## Creating SageMaker Studio Domains using CloudFormation

Amazon SageMaker Studio (https://docs.aws.amazon.com/sagemaker/latest/dg/gs-studio.html) is the first fully integrated development environment (IDE) for machine learning (ML). It provides a single, web-based visual interface where you can perform all ML development steps required to build, train, tune, debug, deploy, and monitor models. AWS CloudFormation (https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html) gives you an easy way to model a collection of related AWS and third-party resources, provision them quickly and consistently, and manage them throughout their lifecycle, by treating infrastructure as code.

In this blog post, we want to demonstrate how you can create a SageMaker Studio domain using CloudFormation. 

## How to run

First, make sure you don't have existing Studio domain. Because at the time of writing, an AWS account is limited to one domain per region. Creating extra domain will cause error. 

The easiest way is to use shell script: `deploy.sh`

If you want to create the stack from AWS Management Console, **make sure** 1) your S3 bucket is versioned, 2) you enter the correct version for `function.zip`, 3) enter the correct subnet ID and VPCId. 

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

