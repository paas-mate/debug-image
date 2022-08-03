#!/bin/bash

DIR="$( cd "$( dirname "$0"  )" && pwd  )"

bash $DIR/build-push-debug.sh nginx-ssl
bash $DIR/build-push-debug.sh ssh
