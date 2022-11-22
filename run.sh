#!/bin/bash

# https://github.com/jtblin/kube2iam/issues/122

attempt=0
exitCode=0
response=0
max_attempts=${MAX_ATTEMPTS:-30}
jitter=${JITTER:-5}

while [[ $attempt -lt $max_attempts ]] ; do
  # Jitter requests to break resource contention
  timeout=$((1 + RANDOM % jitter))

  # 169.254.169.254/latest/meta-data is reserved by AWS to access the Metadata API to retrieve IAM credentials.
  #   https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html
  # This curl command is hitting the Metadata API which routes through Kube2iam via IP Tables
  #   https://github.com/jtblin/kube2iam#iptables
  # If the requests return a 200OK, then it's implied that we can communicate with Kube2iam
  response=$(curl --write-out %{http_code} --silent --output /dev/null --connect-timeout 2 'http://169.254.169.254/latest/meta-data/iam/security-credentials/')

  if [[ $response == 200 ]] ; then
    exitCode=0
    break
  fi

  echo "Attempt #${attempt}. Failure connecting to Kube2iam! Retrying in ${timeout}s." 1>&2

  sleep $timeout
  attempt=$(( attempt + 1 ))
done

exec "$@"
