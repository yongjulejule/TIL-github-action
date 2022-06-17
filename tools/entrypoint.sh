#!/usr/bin/env sh

node -v
echo "hello action with docker"

echo "console.log('hello action with docker in node')"  | node 

exec "$@"