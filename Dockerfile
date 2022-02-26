FROM node:14-alpine

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

RUN npm install -g npm@latest \
  && npm install -g serverless@3.4.0

ENTRYPOINT ["/bin/bash", "-c"]
