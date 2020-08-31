#!/bin/sh

rm -rf ../rubik-mdbook-build
rm -rf ../rubik-mdbook-build-interm
mkdir ../rubik-mdbook-build
mkdir ../rubik-mdbook-build-interm && cd ../rubik-mdbook-build-interm
cd ..
# rm -rf rubik-mdbook-build/*
cd rubik-mdbook/
mdbook build -d ../rubik-mdbook-build-interm
cd ../rubik-mdbook-build
git init
git remote add origin https://github.com/rubikorg/rubikorg.github.io.git
git fetch --all
git checkout master
git pull origin master

cp -R ../rubik-mdbook-build-interm/* .
git add .
echo "\n\nCommiting !!"
git commit -m "mdbook: update docs"
git push --set-upstream origin master

cd ..

echo "\n\nCleaning up !!"
rm -rf rubik-mdbook-build/
rm -rf rubik-mdbook-build-interm/
