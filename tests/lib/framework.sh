#!/bin/sh

# 
# Test Framework
# 

assertEquals()
{
    msg=$1
    expected=$2
    actual=$3

    if [ "$expected" != "$actual" ]; then
        echo "FAILED: $msg: EXPECTED=$expected ACTUAL=$actual"
    else
        echo "PASSED: $msg"
    fi
}

assertNotEquals()
{
    msg=$1
    expected=$2
    actual=$3

    if [ "$expected" == "$actual" ]; then
        echo "FAILED: $msg: Expected and actual match. ACTUAL=$actual"
    else
        echo "PASSED: $msg"
    fi
}