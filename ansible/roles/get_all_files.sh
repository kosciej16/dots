#!/bin/bash

for f in $(find . -name "get_files.sh") ; do
    echo $f
    pushd $(dirname $f)
    ./get_files.sh
    popd
done
