rm -rf ../rubikorg.github.io/*
hugo -d ../rubikorg.github.io
cd ../rubikorg.github.io
git add .
git commit -m "deploy docs"
git push origin master
cd ../rubik-docs-new

echo "Done !!"

 
