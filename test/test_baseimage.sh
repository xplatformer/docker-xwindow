#!/bin/sh

# Variables
#
# Variables of the script.
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
ROOT_DIR="$(dirname $DIR)"
BIN_DIR="${DIR}/target"
DATA_DIR="${DIR}/resources"

# Tests
#
# The functions that test certain functionality.

function install()
{
    apt-get update >/dev/null 2>&1
    apt-get install -y zip >/dev/null 2>&1
}

function version() 
{
    g++ --version
}

function simple_compile()
{
    g++ $DATA_DIR/test.cpp -o $BIN_DIR/test >/dev/null 2>&1
    (cd $BIN_DIR && ./test)
}

# Test Runner
#
# Runs the tests.
(
    function assertEquals()
    {
        msg=$1
        expected=$2
        actual=$3

        if [ "$expected" != "$actual" ]; then
            echo "$msg: FAILED: EXPECTED=$expected ACTUAL=$actual"
        else
            echo "$msg: PASSED"
        fi
    }

    echo "Testing image for baseimage."
    mkdir -p $BIN_DIR
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