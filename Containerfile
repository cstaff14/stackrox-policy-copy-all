FROM registry.access.redhat.com/ubi8/ubi:8.3-297
LABEL maintainer="castaffo@redhat.com"

ARG rox-api-token
ARG rox-central-address

ENV ROX_API_TOKEN $rox-api-token
ENV ROX_ENDPOINT $rox-central-address

RUN yum install jq -y && \
    yum install curl -y && \
    yum install git -y && \
    yum clean all

RUN groupadd -r rox-user && useradd -r -g rox-user student

USER rox-user

WORKDIR /home/rox-user

RUN git clone https://github.com/stackrox/contributions.git

WORKDIR /home/rox-user/contributions/util-scripts/policy-copy-all

CMD ["./policy-copy-all.sh"]