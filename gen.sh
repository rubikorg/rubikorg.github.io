#!/bin/sh

rm -rf build
mkdir build && cd build
git init
git remote add origin https://github.com/rubikorg/rubikorg.github.io.git
git fetch --all
git pull origin master

cd ..
rm -rf build/
mdbook build -d build
cd build
git add .
git commit -m "mdbook: update docs"
