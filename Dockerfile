FROM public.ecr.aws/docker/library/node:20-alpine

# Install system dependencies and AWS CLI in a single layer
RUN apk add --no-cache \
  python3 \
  py3-pip \
  ca-certificates \
  groff \
  less \
  bash \
  aws-cli && \
  # Clean up pip cache
  rm -rf /root/.cache/pip/*

# Set environment variables
ENV NODE_ENV=development \
  SERVERLESS_VERSION=4.18.2

# Install Node.js global packages and clean up npm cache in a single layer
RUN npm install -g serverless@${SERVERLESS_VERSION} pnpm && \
  npm cache clean --force

# Create a non-root user for better security
RUN addgroup -g 1001 -S serverless && \
  adduser -S -D -H -u 1001 -h /app -s /sbin/nologin -G serverless serverless

# Set working directory
WORKDIR /app

# Change ownership of the working directory
RUN chown -R serverless:serverless /app

# Switch to non-root user
USER serverless

ENTRYPOINT ["/bin/bash", "-c"]
