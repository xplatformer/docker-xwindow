FROM jrbeverly/baseimage:ubuntu-17.04

# 
# Build Arguments
#
ARG DEBIAN_FRONTEND=noninteractive

#
# Provision
#
COPY provision/install.sh /tmp/install.sh
RUN sh /tmp/install.sh && rm -f /tmp/install.sh

# Volumes
#
# Volumes exposed by the docker container.
VOLUME /media

# 
# Options
# 
WORKDIR /media
ENTRYPOINT []
CMD []

#
# User
#
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
    org.label-schema.summary="A super small Alpine image providing a x11 build image." \
    org.label-schema.description="Provides the sufficient dependendencies for an X11 environment." \
    org.label-schema.maintainer="jrbeverly" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.version=$VERSION \
    org.label-schema.url="" \
    org.label-schema.license="MIT" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://gitlab.com/jrbeverly-docker/docker-xwindow" \
    org.label-schema.docker.cmd="docker run -v $(pwd):/media/ jrbeverly/xwindow:baseimage g++ test.cpp -o test" \
    \
    io.jrbeverly.project="xwindow" \
    io.jrbeverly.summary="A small x11 build image, running as the $USER user." \
    io.jrbeverly.xwindow.meta.BUILD_DATE="The Date/Time the image was built." \
    io.jrbeverly.xwindow.meta.VERSION="Release identifier for the contents of the image." \
    io.jrbeverly.xwindow.meta.VCS_REF="Identifier for the version of the source code from which this image was built." \
    io.jrbeverly.xwindow.args.USER="Sets the [user](http://www.linfo.org/uid.html) to use when running the image." \
    io.jrbeverly.xwindow.volume.media="/media/|The default working directory of the image."
