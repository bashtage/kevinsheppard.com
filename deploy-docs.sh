#!/usr/bin/env bash

echo "Set git email and name"
git config user.email "kevin.k.sheppard@gmail.com"
git config user.name "Kevin Sheppard"
echo "Checkout pages"
git checkout gh-pages
echo "Copy docs to root"
echo cp -r ${PWD}/site/output/* ${PWD}/
cp -r ${PWD}/site/output/* ${PWD}/
git add .
echo "Change remote"
git remote set-url origin https://bashtage:"${GH_PAGES_TOKEN}"@github.com/bashtage/kevinsheppard.com.git
echo "Github Actions doc build after commit ${GITHUB_SHA::8}"
git commit -a -m "Github Actions doc build after commit ${GITHUB_SHA::8}"
echo "Push"
git push -f
