FROM buildkite/agent:3

ARG S6_OVERLAY_RELEASE=https://github.com/just-containers/s6-overlay/releases/latest/download/s6-overlay-amd64.tar.gz
ENV S6_OVERLAY_RELEASE=${S6_OVERLAY_RELEASE}
ADD ${S6_OVERLAY_RELEASE} /tmp/s6overlay.tar.gz

RUN apk update && apk add docker ip6tables && tar xzf /tmp/s6overlay.tar.gz -C / && rm /tmp/s6overlay.tar.gz

COPY ./entrypoint.sh /usr/local/bin/buildkite-agent-entrypoint

RUN mkdir -p /etc/services.d/docker /etc/services.d/buildkite-agent
COPY run-docker /etc/services.d/docker/run
COPY run-buildkite-agent /etc/services.d/buildkite-agent/run
COPY entrypoint.sh /entrypoint

ENTRYPOINT ["/entrypoint"]