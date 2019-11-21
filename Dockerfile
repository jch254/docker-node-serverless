FROM node:10-alpine

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

RUN yarn global add serverless@1.58.0

ENTRYPOINT ["/bin/bash", "-c"]
