#!/usr/bin/env bash

set -e

for f in "hello" "driver" "extend" "control" "bit"
do
    cd "$f"
    make
    make test
    make clean
    cd ..
    echo ""
done
