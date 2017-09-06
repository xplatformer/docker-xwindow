#!/usr/bin/env bats

#
# Filesystem
#
DIR_TESTS="$(dirname $(readlink -f "$0"))"

#
# Tests
#

@test "user is root" {
    run docker run --rm "${DOCKER_IMAGE_NAME}" id -u
    [ "$output" == "0" ]
}

@test "g++ is installed" {
	run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which g++"
    [ "$status" -eq 0 ]
}

@test "cache is empty" {
    run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "ls -1 /var/cache/apk | wc -l"
    [ "$status" -eq 0 ]
}

@test "apt-get is enabled" {
    run docker run --rm "${DOCKER_IMAGE_NAME}" apt-get update
    [ "$status" -eq 0 ]
}

@test "compile program" {
    docker run --rm -v "${DOCKER_PATH}":/media --workdir /media "${DOCKER_IMAGE_NAME}" sh resources/compile.sh test1
    [ "$?" -eq 0 ]
}

@test "compile x11 program" {
    docker run --rm -v "${DOCKER_PATH}":/media --workdir /media "${DOCKER_IMAGE_NAME}" sh resources/compile.sh test2 
    [ "$?" -eq 0 ]
}