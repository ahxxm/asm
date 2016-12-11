#!/usr/bin/env bash

set -e

for f in $(ls -d */)
do
    cd "$f"
    make
    make test
    make clean
    cd ..
    echo ""
done
