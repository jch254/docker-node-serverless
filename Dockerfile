FROM nodesource/jessie:4.3.2

RUN apt-get update
RUN apt-get install -y unzip

RUN npm install -g serverless

RUN wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
RUN unzip awscli-bundle.zip
RUN ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

ENTRYPOINT ["/bin/bash", "-c"]
