#!/bin/bash
git add -A
git commit -am "update: $(date "+%Y-%m-%d %H:%M:%S")"
git push
