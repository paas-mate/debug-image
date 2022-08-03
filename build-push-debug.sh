#!/bin/bash

function main() 
{
    cd dockerfile/"$1"
    docker build . -t ttbb/debug:$1
    docker push ttbb/debug:$1
}

cd "$(dirname "$0")"
main "$1"
