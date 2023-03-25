#!/bin/bash

/tmp/generateREADME.sh -f README.md

cd $GITHUB_WORKSPACE

git config --global --add safe.directory /github/workspace
git config --local user.email "action@github.com"
git config --local user.name "GitHub Action"
git switch -c readme-bot
git add README.md
git commit -m "Update README.md"
git push origin readme-bot
