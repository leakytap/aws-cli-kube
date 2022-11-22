# aws-cli-docker
Docker image for the [AWS CLI](https://docs.aws.amazon.com/cli/latest/reference/) will ensure that the credentials are available on the container before continuing with the aws-cli command.

It is intended to be ran in kubernetes on EC2 instances and uses the [ec2 meta-data endpoint](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html) to function.
