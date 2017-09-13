FROM ubuntu:17.04

#
# Build Arguments
#
ARG DEBIAN_FRONTEND=noninteractive

#
# Environment Variables
#
ENV HOME=/

#
# Provision
#
COPY provision/install.sh /tmp/install.sh
RUN sh /tmp/install.sh && rm -f /tmp/install.sh

#
# Options
#
WORKDIR /media
ENTRYPOINT []
CMD []

#
# User
#
ARG DUID
ARG DGID
RUN addgroup --gid ${DGID} --system docker && adduser --system --uid ${DUID} --gid ${DGID} docker

ARG USER
USER $USER

#
# Metadata Arguments
#
ARG BUILD_DATE
ARG VERSION
ARG VCS_REF

#
# Metadata
#
LABEL \
    maintainer="jrbeverly" \
    \
    org.label-schema.name="xwindow" \
    org.label-schema.summary="A super small image providing a x11 build image." \
    org.label-schema.description="Provides the sufficient dependendencies for an X11 environment." \
    org.label-schema.maintainer="jrbeverly" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.version=$VERSION \
    org.label-schema.url="https://www.x.org/wiki/" \
    org.label-schema.license="MIT" \
    org.label-schema.docker.cmd="docker run -v $(pwd):/media/ jrbeverly/xwindow:privileged g++ myxapp.cpp -o xapp" \
    org.label-schema.vendor="jrbeverly" \
    org.label-schema.schema-version="1.0" \
    \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://gitlab.com/jrbeverly-docker/docker-xwindow" \
    \
    org.doc-schema.project="xwindow" \
    org.doc-schema.summary="A small x11 build image, running as the $USER user." \
    org.doc-schema.user=$DUID \
    org.doc-schema.group=$DGID