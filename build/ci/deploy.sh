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

echo "# Preparing image tags for release"
for dir in $DIR_VERSIONS/*/; 
do 
  version=$(basename ${dir%*/}); 
  
  make -s -C "${DIR_BUILD}" VERSION=${version} release
done

echo "# Deploying the image tags"
for dir in $DIR_VERSIONS/*/; 
do 
  version=$(basename ${dir%*/}); 
  
  make -s -C "${DIR_BUILD}" VERSION=${version} deploy
done