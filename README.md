# Creating Amazon SageMaker Domains using AWS CloudFormation

Amazon SageMaker Studio (https://docs.aws.amazon.com/sagemaker/latest/dg/gs-studio.html) is the first fully integrated development environment (IDE) for machine learning (ML). 
It provides a single, web-based visual interface where you can perform all ML development steps required to build, train, tune, debug, deploy, and monitor models. 

AWS CloudFormation (https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html) gives you an easy way to model a collection of related AWS and third-party resources, provision them quickly and consistently, and manage them throughout their lifecycle, by treating infrastructure as code.

In this repository, we want to provide an AWS CloudFormation template for safely deploying a SageMaker Domain in a VPC. This template is configured to include all required permissions for SageMaker Studio, SageMaker Canvas, and other functionalities.

## How to run from Management Console

1. Download the template in this repository, [here](./sagemaker-domain-with-vpc.yaml)
2. Head over to [AWS CloudFormation Console](https://console.amazon.com/cloudformation), make sure you're in the right region
3. Click “Create Stack”, select “Choose an existing template”, and “Upload a template file”.
4. Upload the template filedownloaded in step 1
5. Provide the required parameters, click “Next”, confirm you allow the creation of IAM resources by selecting the checkbox, then click “Create”
6. Wait until completed. You're done! 🎉️

## How to run from command line

`aws cloudformation deploy --stack-name <stack-name> --template-file sagemaker-domain-with-vpc.yaml --capabilities CAPABILITY_IAM`

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the [LICENSE](LICENSE) file.
