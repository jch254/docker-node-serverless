FROM node:8.10.0-alpine

RUN apk add --no-cache \
  python \
  py-pip \
  py-setuptools \
  ca-certificates \
  groff \
  less \
  bash && \
  pip install --no-cache-dir --upgrade pip awscli

ENV NODE_ENV development

RUN yarn global add serverless@1.36.1

ENTRYPOINT ["/bin/bash", "-c"]
