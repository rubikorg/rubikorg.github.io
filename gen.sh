mkdocs build -d ../rubikorg.github.io --clean
cd ../rubikorg.github.io
git add .
git commit -am "deploy docs"
git push origin master
cd ../cherry-docs

echo "Done !!!"
