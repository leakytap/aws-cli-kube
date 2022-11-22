FROM amazon/aws-cli

LABEL org.opencontainers.image.source "https://github.com/leakytap/aws-cli-kube"
LABEL org.opencontainers.image.description "Docker image for the AWS CLI to use in Kubernetes"

RUN yum install -y nc \
    && yum clean all

ADD run.sh /scripts/run.sh

ENTRYPOINT ["/scripts/run.sh"]
