#!/bin/bash

git fetch kjp
git reset --hard FETCH_HEAD
git clean -df
