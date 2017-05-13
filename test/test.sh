#!/bin/sh
set -ex

g++ --version
g++ test.cpp -o test
./test