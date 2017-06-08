#!/bin/sh

# Tests
#
# A set of common functions that should be tested on the docker image.

install() {
    apt-get update >/dev/null 2>&1
    apt-get install -y zip >/dev/null 2>&1
}

version() {
    g++ --version >/dev/null 2>&1
}

simple_compile() {
    g++ $DIR_RESOURCES/test.cpp -o $DIR_TARGET/test >/dev/null 2>&1
    (cd $DIR_TARGET && ./test) >/dev/null 2>&1
}