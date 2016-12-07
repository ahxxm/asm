#!/usr/bin/env bash

set -e

for f in "hello" "driver" "extend" "control" "bit" "call" "multimodule" "inter-c" "array" "mem"
do
    cd "$f"
    make
    make test
    make clean
    cd ..
    echo ""
done
