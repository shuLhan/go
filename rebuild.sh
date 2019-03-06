#!/bin/sh

git remote prune origin
git fetch --all --tags
git checkout master
git rebase origin/master
cd src
export GOFLAGS=-vet=off
time ./all.bash

echo
echo ">>> Rebuilding github.com/golangci/golangci-lint"
cd ~/go/src/github.com/shuLhan/golangci-lint/cmd/golangci-lint && go install .

echo
echo ">>> Rebuilding golang.org/x/tools"
git pull --rebase
cd ~/go/src/golang.org/x/tools && go install ./cmd/...
cd ~/go/src/golang.org/x/tools/gopls && go install .

echo
echo ">>> Rebuilding golang.org/x/review"
cd ~/go/src/golang.org/x/review/git-codereview && go install .
