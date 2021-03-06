#!/usr/bin/env bats

#
# Filesystem
#
DIR_TESTS="$(dirname $(readlink -f "$0"))"

DIR_LIBRARY="${DIR_TESTS}/lib"
DIR_RESOURCES="${DIR_TESTS}/resources"
DIR_TARGET="${DIR_TESTS}/target"

#
# Tests
#
@test "user is not root" {
    run docker run --rm "${DOCKER_IMAGE_NAME}" id -u
    echo "status: $status"
    echo "output: $output"
    [ "$output" != "0" ]
}

@test "g++ is installed" {
	run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which g++"
    echo "status: $status"
    [ "$status" -eq 0 ]
}

@test "bash is installed" {
	run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which bash"
    echo "status: $status"
    [ "$status" -eq 0 ]
}

@test "gcc is installed" {
	run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which gcc"
    echo "status: $status"
    [ "$status" -eq 0 ]
}

@test "make is installed" {
	run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which make"
    echo "status: $status"
    [ "$status" -eq 0 ]
}

@test "cache is empty" {
    run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "ls -1 /var/lib/apt/lists/ | wc -l"
    echo "status: $status"
    [ "$status" -eq 0 ]
}

@test "tmp is empty" {
    run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "ls -1 /var/tmp/ | wc -l"
    echo "status: $status"
    [ "$status" -eq 0 ]
}

@test "apt-get is disabled" {
    run docker run --rm "${DOCKER_IMAGE_NAME}" apt-get update
    echo "status: $status"
    echo "output: $output"
    [ "$status" -ne 0 ]
}

@test "compile program" {
    run docker run --rm -v "${DOCKER_PATH}":/media --workdir /media "${DOCKER_IMAGE_NAME}" sh resources/compile.sh test1
    echo "status: $status"
    echo "output: $output"
    [ "$status" -eq 0 ]
}

@test "compile x11 program" {
    run docker run --rm -v "${DOCKER_PATH}":/media --workdir /media "${DOCKER_IMAGE_NAME}" sh resources/compile.sh test2 
    echo "status: $status"
    echo "output: $output"
    [ "$status" -eq 0 ]
}

@test "the image uses label-schema.org" {
    run docker inspect -f '{{ index .Config.Labels "org.label-schema.schema-version" }}' "${DOCKER_IMAGE_NAME}"
    echo "status: $status"
    echo "output: $output"
    [ "$status" -eq 0 ]
    [ "$output" = "1.0" ]
}

@test "the image has a build-date" {
    run docker inspect -f '{{ index .Config.Labels "org.label-schema.build-date" }}' "${DOCKER_IMAGE_NAME}"
    echo "status: $status"
    echo "output: $output"
    [ "$status" -eq 0 ]
    [ "$output" != "" ]
}

@test "the image has a maintainer" {
    run docker inspect -f '{{ index .Config.Labels "maintainer" }}' "${DOCKER_IMAGE_NAME}"
    echo "status: $status"
    echo "output: $output"
    [ "$status" -eq 0 ]
    [ "$output" != "" ]
}

@test "the image has a user identifier" {
    run docker inspect -f '{{ index .Config.Labels "org.doc-schema.user" }}' "${DOCKER_IMAGE_NAME}"
    echo "status: $status"
    echo "output: $output"
    [ "$status" -eq 0 ]
    [ "$output" == "9000" ]
}

@test "the image has a group identifier" {
    run docker inspect -f '{{ index .Config.Labels "org.doc-schema.group" }}' "${DOCKER_IMAGE_NAME}"
    echo "status: $status"
    echo "output: $output"
    [ "$status" -eq 0 ]
    [ "$output" == "9000" ]
}