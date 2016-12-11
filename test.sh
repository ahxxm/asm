#!/usr/bin/env bash

set -e

for f in $(ls -d */)
do
    if [ "$f" != "inc/" ];
    then
       echo "$f"
       cd "$f"
       make
       make test
       make clean
       cd ..
       echo ""
    fi
done
