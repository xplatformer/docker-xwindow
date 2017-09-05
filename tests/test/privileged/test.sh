#!/bin/sh

#
# Variables
#
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
DIR_TESTS="$(dirname $(dirname $DIR))"

DIR_LIBRARY="${DIR_TESTS}/lib"
DIR_RESOURCES="${DIR_TESTS}/resources"
DIR_TARGET="${DIR_TESTS}/target"

#
# Tests
#
. $DIR_LIBRARY/framework.sh

simple_compile() {
    g++ $DIR_RESOURCES/test.cpp -o $DIR_TARGET/test >/dev/null 2>&1
    (cd $DIR_TARGET && ./test) >/dev/null 2>&1
}

# 
# Test Runner
#
(
    rm -rf $DIR_TARGET
    mkdir -p $DIR_TARGET
    
    (
      apt-get update >/dev/null 2>&1
      apt-get install -y zip >/dev/null 2>&1

      assertEquals "install to image" 0 $?
    )

    (
      g++ --version >/dev/null 2>&1

      assertEquals "g++ installed" 0 $?
    )

    (
      RESULT=$(simple_compile)
      assertEquals "simple compile" 45 $?
    )
)