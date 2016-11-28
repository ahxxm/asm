#!/usr/bin/env bash

set -e

for f in "hello" "driver" "extend"
do
    cd "$f"
    make
    make test
    make clean
    cd ..
done
