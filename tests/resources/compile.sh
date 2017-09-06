#!/bin/sh
set -e

test1() {
    mkdir -p target/
    g++ resources/test1.cpp -o target/test1

    (cd target/ && ./test1)
}

test2() {
    mkdir -p target/
    g++ resources/x11.cpp -I/usr/X11R6/include -I/usr/X11R6/include/X11 -L/usr/X11R6/lib -L/usr/X11R6/lib/X11 -lX11 -o target/x11

    (cd target/ && ./x11)
}

"$@"