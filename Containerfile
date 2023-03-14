FROM registry.access.redhat.com/ubi8/ubi:8.3-297
LABEL maintainer="castaffo@redhat.com"

ARG rox-api-token
ARG rox-central-address

ENV ROX_API_TOKEN $rox-api-token
ENV ROX_ENDPOINT $rox-central-address

RUN yum install jq -y && \
    yum install curl -y && \
    yum clean all

RUN groupadd -r rox-user && useradd -r -g rox-user rox-user

COPY --chown=rox-user:rox-user policy-copy-all.sh /home/rox-user/policy-copy-all.sh

USER rox-user

WORKDIR /home/rox-user

CMD ["./policy-copy-all.sh"]