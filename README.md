# docker-node-serverless

[![Docker Pulls](https://img.shields.io/docker/pulls/jch254/docker-node-serverless)](https://hub.docker.com/r/jch254/docker-node-serverless)
[![Image Size](https://img.shields.io/docker/image-size/jch254/docker-node-serverless/latest)](https://hub.docker.com/r/jch254/docker-node-serverless)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Minimal, repeatable build & deployment container for AWS Serverless Framework services. Intended for CI environments like Bitbucket Pipelines, AWS CodeBuild, GitHub Actions, GitLab CI, etc.

> Baseline runtime: **Node.js 22 (Alpine)** — AWS Lambda supports `nodejs22.x` (see: [Lambda runtimes](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html)).

## What's Included

| Component | Details |
|-----------|---------|
| Node.js | 22 (Alpine base image) |
| Serverless Framework | v4.20.2 (pinned via `SERVERLESS_VERSION` ENV) |
| AWS CLI v2 | Alpine package install |
| Package managers | npm (bundled), pnpm (global), Yarn (bundled) |
| Python 3 + pip | For plugins / build tooling needing Python |
| Shell & utils | bash, less, groff, ca-certificates |
| User | Non-root `serverless` (UID 1001), WORKDIR `/app` |

## Image Tags / Branch Mapping

| Node Line | Branch / Tag | Status |
|-----------|--------------|--------|
| 22 | `22.x` | Recommended (current focus) |
| 20 | `20.x` | Still supported (earlier Lambda support window) |
| 18 | `18.x` | Approaching end of support |
| 16 | `16.x` | Deprecated (legacy only) |

`master` tracks the active major (Node 22). Pin a major tag (`22.x`) for deterministic CI builds.

## Quick Start

Pull the image:

```bash
docker pull jch254/docker-node-serverless:22
```

Check versions:

```bash
docker run --rm jch254/docker-node-serverless:22 serverless --version
docker run --rm jch254/docker-node-serverless:22 node -v
```

Deploy (mount your service directory):

```bash
docker run --rm -it \
  -v "$PWD":/app \
  -w /app \
  -e AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY \
  -e AWS_REGION=us-east-1 \
  jch254/docker-node-serverless:22 \
  serverless deploy --stage dev
```

## Bitbucket Pipelines Example

```yaml
pipelines:
  default:
    - step:
        image: jch254/docker-node-serverless:22
        caches:
          - node
        script:
          - pnpm install # or npm ci / yarn install
          - serverless deploy --stage dev
```

## GitHub Actions Example

```yaml
name: Deploy
on: [push]
jobs:
  deploy:
    runs-on: ubuntu-latest
    container: jch254/docker-node-serverless:22
    steps:
      - uses: actions/checkout@v4
      - name: Install deps
        run: pnpm install --frozen-lockfile
      - name: Deploy
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_REGION: us-east-1
        run: serverless deploy --stage prod
```

## AWS CodeBuild `buildspec.yml` Example

```yaml
version: 0.2
phases:
  install:
    runtime-versions: {}
  build:
    commands:
      - pnpm install --frozen-lockfile
      - serverless deploy --stage prod
```

## Package Managers

Use whichever you prefer:

```bash
# pnpm
pnpm install
serverless package

# npm
npm ci
serverless deploy

# Yarn
yarn install --frozen-lockfile
serverless remove
```

## AWS Credentials

Provide credentials via environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, optional `AWS_SESSION_TOKEN`, `AWS_REGION`) or mount a credentials directory:

```bash
docker run --rm \
  -v $HOME/.aws:/home/serverless/.aws:ro \
  -v $PWD:/app -w /app \
  jch254/docker-node-serverless:22 serverless info
```

## Non-Root User & Permissions

The image runs as `serverless` (UID 1001). If you encounter permission issues writing to a bind mount created by root (e.g., on some CI agents), you can temporarily override the user:

```bash
docker run --rm -u 0 jch254/docker-node-serverless:22 chown -R 1001:1001 /app
```

Or run a one-off global install:

```bash
docker run --rm -u 0 jch254/docker-node-serverless:22 npm install -g serverless-plugin-aws-alerts
```

## Extending the Image

```dockerfile
FROM jch254/docker-node-serverless:22
RUN npm install -g serverless-plugin-aws-alerts
```

Build:

```bash
docker build -t my/serverless-image:22 .
```

## Upgrading Notes (Node 20 -> 22, Serverless 3 -> 4)

Review the following when upgrading:

- Update any `runtime` fields in `serverless.yml` to `nodejs22.x` (if not deploying via container images).
- Serverless v4 drops deprecated CLI flags—remove legacy options (e.g. old `--aws-s3-accelerate` if used).
- Rebuild native dependencies (node-gyp) to target Node 22 ABI if packaging layers/binaries.
- Verify plugins are compatible; update to latest maintained versions.

## Troubleshooting

| Symptom | Resolution |
|---------|------------|
| EACCES on write to /app | Ensure host directory ownership or run with `-u 0` briefly to fix perms |
| AWS auth errors | Confirm env vars, or mount `~/.aws` with correct profile |
| Plugin missing system libs | Create derived image adding `apk add <lib>` |
| Slow cold start bundle size | Use `serverless package` + prune dev deps, leverage layers |

## Reference Links

- Serverless Framework: <https://www.serverless.com/>
- AWS Lambda runtimes: <https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html>
- pnpm: <https://pnpm.io/>

## Contributing

PRs welcome: keep layers minimal, versions pinned where helpful, and document added tools.

## License

MIT

---
Feedback & improvements welcome.
