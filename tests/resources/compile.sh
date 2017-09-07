#!/bin/sh
set -e

test1() {
    dir=/tmp

    mkdir -p $dir
    g++ resources/test1.cpp -o $dir/test1

    (cd $dir && ./test1)
}

test2() {
    dir=/tmp

    mkdir -p $dir
    g++ resources/x11.cpp -I/usr/X11R6/include -I/usr/X11R6/include/X11 -L/usr/X11R6/lib -L/usr/X11R6/lib/X11 -lX11 -o $dir/x11

    (cd $dir && ./x11)
}

"$@"