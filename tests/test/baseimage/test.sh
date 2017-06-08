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
. $DIR_LIBRARY/testbase.sh

# 
# Test Runner
#
(
    mkdir -p $DIR_TARGET
    (
      RESULT=$(install)
      assertEquals "cannot install to image" 100 $?
    )

    (
      RESULT=$(version)
      assertEquals "g++ installed" 0 $?
    )

    (
      RESULT=$(simple_compile)
      assertEquals "simple compile" 45 $?
    )
)