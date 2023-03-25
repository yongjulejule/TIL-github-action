#!/bin/bash

echo "hello action with docker"

echo "this is github output about-til='thisisTIL'" > ${GITHUB_OUTPUT:-/dev/stdout}

if [[ $1 =~ "generateREADME.sh" ]]; then
  set -- $@ -f README.md
  exec $@
fi

exec "$@" 
