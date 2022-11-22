# aws-cli-docker
Docker image for the [AWS CLI](https://docs.aws.amazon.com/cli/latest/reference/) that runs a web server on port `9000` after running any scripts in the `init` directory to be used by a [wait-for-it](https://github.com/vishnubob/wait-for-it) script.

The wait-for-it script is available inside the docker image as well at `/scripts/wait-for-it.sh` to be used in your script.
## Usage

Docker:
``` bash
docker run -it ghcr.io/leakytap/aws-cli-docker:latest
```

Docker compose:
``` yaml
version: "3.5"
services:
  aws:
    image: ghcr.io/leakytap/aws-cli-docker:latest
    environment:
      AWS_REGION: "us-west-2"
      AWS_ACCESS_KEY_ID: key
      AWS_SECRET_ACCESS_KEY: secret=value
    volumes:
      - ./init:/init
    ports:
      - 9000:9000
```
