#!/bin/bash

set -x

trap 'kill $(jobs -p)' SIGTERM SIGINT EXIT

echo "hello action with docker"


echo "this is github output" > ${GITHUB_OUTPUT:-/dev/stdout}

exec "$@"
