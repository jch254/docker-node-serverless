FROM node:20-alpine

RUN apk add --no-cache \
  python3 \
  py-pip \
  py-setuptools \
  ca-certificates \
  groff \
  less \
  bash \
  aws-cli

ENV NODE_ENV development

RUN npm install -g serverless@3.38.0

ENTRYPOINT ["/bin/bash", "-c"]
