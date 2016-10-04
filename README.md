# docker-node-serverless

Docker-powered build/deployment environment for Serverless projects. This Docker image is intended for use with [Bitbucket Pipelines](https://bitbucket.org/product/features/pipelines) - see bitbucket-pipelines-example.yml as an example to use in a Serverless project.

--

This image is based on nodesource/jessie:4.3.2 ([AWS Lambda uses Node v4.3.2](http://docs.aws.amazon.com/lambda/latest/dg/current-supported-versions.html)) and has the AWS CLI and Serverless 1.0.0-rc.2 installed.

To deploy a Serverless service to AWS you will need to create an IAM user with the required permissions and set credentials for this user - see [here](https://github.com/serverless/serverless/blob/master/docs/02-providers/aws/01-setup.md) for further info. I'm setting credentials in bitbucket-pipelines-example.yml so I can take advantage of [Bitbucket Pipelines environment variables](https://confluence.atlassian.com/bitbucket/environment-variables-in-bitbucket-pipelines-794502608.html); however setting credentials in Dockerfile is also possible.

Unfortunately a list of required IAM permissions is not specified by Serverless. I've created a bitbucket-pipelines IAM user with Lambda:FullAccess, APIGateway:FullAccess, S3:FullAccess, CloudFormation:FullAccess, iam:GetRole and iam:CreateRole which is sufficient to deploy (this could be more fine-grained).
