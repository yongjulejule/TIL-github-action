#!/usr/bin/env sh

node -v
echo "hello action with docker"

node <<< "hello action with docker in node"

exec "$@"