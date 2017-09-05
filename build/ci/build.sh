#!/bin/sh

#
# Variables
#
DIR="$(dirname $(readlink -f "$0"))"
DIR_ROOT="$(dirname $(dirname $DIR))"
DIR_BUILD="${DIR_ROOT}/build"
DIR_VERSIONS="${DIR_ROOT}/versions"

#
# Executing
#
for dir in $DIR_VERSIONS/*/; 
do 
  version=$(basename ${dir%*/}); 
  
  make -s -C "${DIR_BUILD}" VERSION=${version} build
done