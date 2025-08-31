FROM node:22-alpine

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

RUN npm install -g serverless@4.18.2 pnpm

ENTRYPOINT ["/bin/bash", "-c"]
