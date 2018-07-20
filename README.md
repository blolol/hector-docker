# Hector Docker Image

This repository contains a Dockerized version of Blolol's custom [Hector](https://github.com/sstephenson/hector) IRC server.

## Usage

Your Docker container will need the following environment variables set:

| Name | Description |
|------|-------------|
| `AWS_ACCESS_KEY_ID` | AWS access key ID for [hector-mercury](https://github.com/raws/hector-mercury). |
| `AWS_SECRET_ACCESS_KEY` | AWS secret access key for hector-mercury. |
| `BLOLOL_API_KEY` | Blolol API key. |
| `BLOLOL_API_SECRET` | Blolol API secret. |
| `HECTOR_MERCURY_SQS_QUEUE_URL` | AWS SQS queue URL for hector-mercury. |

You can optionally provide these environment variables:

| Name | Description |
|------|-------------|
| `HECTOR_LOG_LEVEL` | One of `debug`, `info`, `warn`, `error`, or `fatal`. Default: `info` |
| `HECTOR_SERVER_NAME` | The server name that is sent to clients. Default: `blolol.irc` |

You should mount a directory at `/usr/src/app/config` with the following files:

* `identities.yml` — Hector user credentials as generated using `hector identity`.
* `certificate_chain.pem` — A chain of X.509 certificates in PEM format, with the most-resolved certificate at the top of the file, intermediate certificates in the middle, and the root (or CA) certificate at the bottom.
* `private_key.pem` — The TLS private key in PEM format.

Hector listens on port 6767 for unencrypted clients, and port 6868 for encrypted clients.

### Generating credentials

You can use the `bin/hash-password` helper script to hash passwords in the correct format for `identities.yml`.

```sh
docker run --rm -i blolol/hector /usr/src/app/bin/hash-password ross s3cr3t
```
