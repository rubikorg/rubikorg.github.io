#!/bin/sh

rm -rf ../rubik-mdbook-build
mkdir ../rubik-mdbook-build && cd ../rubik-mdbook-build
git init
git remote add origin https://github.com/rubikorg/rubikorg.github.io.git
git fetch --all
git pull origin master

cd ..
rm -rf rubik-mdbook-build/*
cd rubik-mdbook/
mdbook build -d ../rubik-mdbook-build
cd rubik-mdbook-build
git add .
git commit -m "mdbook: update docs"

echo "Cleaning up !!"
rm -rf ../rubik-mdbook-build
