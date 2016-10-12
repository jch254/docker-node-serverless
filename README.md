# Docker-node-serverless

[![Dockerhub badge](http://dockeri.co/image/jch254/docker-node-serverless)](https://hub.docker.com/r/jch254/docker-node-serverless)


Docker-powered build/deployment environment for Serverless projects. This Docker image is intended for use with [Bitbucket Pipelines](https://bitbucket.org/product/features/pipelines).

See [serverless-es6-dynamodb-webapi](https://github.com/jch254/serverless-es6-dynamodb-webapi) for an example of this image in action.

---

This image is based on nodesource/jessie:4.3.2 ([AWS Lambda uses Node v4.3.2](http://docs.aws.amazon.com/lambda/latest/dg/current-supported-versions.html)) and has the AWS CLI and Serverless v1.0 installed.

To deploy a Serverless service to AWS you will need to create an IAM user with the required permissions and set credentials for this user - see [here](https://github.com/serverless/serverless/blob/master/docs/02-providers/aws/01-setup.md) for further info. I'm setting credentials in bitbucket-pipelines-example.yml so I can take advantage of [Bitbucket Pipelines environment variables](https://confluence.atlassian.com/bitbucket/environment-variables-in-bitbucket-pipelines-794502608.html); however setting credentials in Dockerfile is also possible.

Unfortunately a list of required IAM permissions is not specified by Serverless. I've created a bitbucket-pipelines IAM user with Lambda:FullAccess, APIGateway:FullAccess, S3:FullAccess, CloudFormation:FullAccess, iam:GetRole, iam:CreateRole and iam:DeleteRole which is sufficient to deploy/manage (this could be more fine-grained).
