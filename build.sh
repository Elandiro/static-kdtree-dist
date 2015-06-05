#!/usr/bin/env bash

if [ "$#" -eq 0 ]; then
    echo "Usage: build.sh <version>"
    exit
fi

set -ex

rm -rf dist/
mkdir dist/

npm install static-kdtree@$1

cd node_modules/static-kdtree
browserify kdtree.js --standalone static-kdtree -o  ../../dist/kdtree.js

cp LICENSE ../../LICENSE

cd ../../

cat > bower.json << EOF
{
  "name": "static-kdtree-dist",
  "version": "$1",
  "authors": [
    "Kim Gressens <kim@kreativgeek.be>"
  ],
  "main": [
    "dist/kdtree.js"
  ],
  "license": "MIT",
  "ignore": [
    "**/.*",
    "build.sh",
    "node_modules",
    "bower_components"
  ]
}
EOF

git add -A .
git commit -a -m "Build static-kdtree v$1"
git tag v$1
