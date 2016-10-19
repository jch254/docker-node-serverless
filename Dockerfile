FROM nodesource/jessie:4.3.2

RUN apt-get update
RUN apt-get install -y unzip wget

ENV NODE_ENV development

RUN npm install -g serverless@1.0.0-rc.2

RUN wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
RUN unzip awscli-bundle.zip
RUN ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

ENTRYPOINT ["/bin/bash", "-c"]
