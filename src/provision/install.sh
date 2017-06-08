#!/bin/sh
set -ex
cd /tmp/

apt-get update
apt-get upgrade -y
apt-get install -y bash make g++ gcc libx11-dev mesa-common-dev libglu1-mesa-dev libxrandr-dev libxi-dev
apt-get autoremove -y

apt-get clean -y
rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/