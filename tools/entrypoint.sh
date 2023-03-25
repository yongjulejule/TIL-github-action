#!/bin/bash

/tmp/generateREADME.sh -f README.md

git config --local user.email "action@github.com"
git config --local user.name "GitHub Action"
git add README.md
git commit -m "Update README.md"
git push origin readme-bot
