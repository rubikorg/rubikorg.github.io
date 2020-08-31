#!/bin/sh

rm -rf ../rubik-mdbook-build
mkdir ../rubik-mdbook-build && cd ../rubik-mdbook-build
cd ..
# rm -rf rubik-mdbook-build/*
cd rubik-mdbook/
mdbook build -d ../rubik-mdbook-build
cd ../rubik-mdbook-build
git init
git remote add origin https://github.com/rubikorg/rubikorg.github.io.git
git fetch --all
git pull origin master
git add .
echo "\n\nCommiting !!"
git commit -m "mdbook: update docs"
git push --set-upstream origin master

echo "\n\nCleaning up !!"
rm -rf ../rubik-mdbook-build
