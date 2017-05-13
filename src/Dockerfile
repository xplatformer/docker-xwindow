FROM ubuntu:17.04
MAINTAINER jrbeverly

# Build Arguments
#
# Arguments used in the build process of the docker container.
ARG DEBIAN_FRONTEND=noninteractive

# Provision
#
# Copy and execute provisioning scripts of the docker container.
COPY provision/install /tmp/install
RUN sh /tmp/install && rm -f /tmp/install 

# Volumes
#
# Volumes exposed by the docker container.
VOLUME /media

# Options
#
# Configuration options of the docker container.
WORKDIR /media
ENTRYPOINT []
CMD []

# User Arguments
#
# Arguments used in the user process of the docker container.
ARG USER

# User
#
# Configuration of the docker user for container execution.
ARG DUID
ARG DGID
ARG USER

# User
#
# Configuration of the docker user for container execution.
RUN addgroup --system --gid ${DGID} docker && adduser --system --ingroup docker --uid ${DUID} docker
USER ${USER}

# Metadata Arguments
#
# Arguments used for the metadata of the docker container.
ARG BUILD_DATE
ARG VERSION
ARG VCS_REF

# Metadata 
#
# The metadata of the docker container.
LABEL \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="xwindow" \
    org.label-schema.description="X11 development environmnet." \
    org.label-schema.url="" \
    org.label-schema.license="MIT" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://gitlab.com/jrbeverly-docker/docker-xwindow.git" \
    org.label-schema.vendor="jrbeverly" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0" \
    io.gitlab.jrbeverly.user="${DUID}" \
    io.gitlab.jrbeverly.group="${DGID}"