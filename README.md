# Docker-node-serverless

[![Dockerhub badge](http://dockeri.co/image/jch254/docker-node-serverless)](https://hub.docker.com/r/jch254/docker-node-serverless)

Docker-powered build/deployment environment for Serverless projects. This Docker image is intended for use with [Bitbucket Pipelines](https://bitbucket.org/product/features/pipelines) and [AWS CodeBuild](https://aws.amazon.com/codebuild).

See [serverless-node-dynamodb-api](https://github.com/jch254/serverless-node-dynamodb-api) for an example of this image in action.

---

This image is based on node:10-alpine ([AWS Lambda uses Node v10.x](http://docs.aws.amazon.com/lambda/latest/dg/current-supported-versions.html)) and has the AWS CLI, Serverless v1.51.0 and Yarn installed.

To deploy a Serverless service to AWS you will need to create an IAM user with the required permissions and set credentials. I'm setting credentials using [Bitbucket Pipelines environment variables](https://confluence.atlassian.com/bitbucket/environment-variables-in-bitbucket-pipelines-794502608.html); however setting credentials in Dockerfile is also possible.
