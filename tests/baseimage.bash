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
    [ "$output" != "0" ]
}

@test "g++ is installed" {
	run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which g++"
    [ "$status" -eq 0 ]
}

@test "cache is empty" {
    run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "ls -1 /var/lib/apt/lists/ | wc -l"
    [ "$status" -eq 0 ]
}

@test "tmp is empty" {
    run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "ls -1 /var/tmp/ | wc -l"
    [ "$status" -eq 0 ]
}

@test "apt-get is disabled" {
    run docker run --rm "${DOCKER_IMAGE_NAME}" apt-get update
    [ "$status" -ne 0 ]
}

@test "compile program" {
    run docker run --rm -v "${DOCKER_PATH}":/media --workdir /media "${DOCKER_IMAGE_NAME}" sh resources/compile.sh test1
    [ "$status" -eq 0 ]
}

@test "compile x11 program" {
    run docker run --rm -v "${DOCKER_PATH}":/media --workdir /media "${DOCKER_IMAGE_NAME}" sh resources/compile.sh test2 
    [ "$status" -eq 0 ]
}