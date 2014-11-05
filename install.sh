#!/bin/bash

# make sure to install vagrant and virtual box:
command -v vagrant >/dev/null || { echo "Vagrant not found. Install vagrant at https://www.vagrantup.com/downloads.html."; exit 1; }
command -v mongo >/dev/null || { echo "Mongo DB not found. Install mongodb to continue."; exit 1; }
command -v mongorestore >/dev/null || { echo "mongorestore not found. Install mongorestore to continue"; exit 1; }
if [ $# -lt 2 ]
  then
    echo "Usage: nodeDev /path/to/install/dir project_name"
    exit 1;
fi

installDir=$1 
projName=$2

echo $installDir
echo $projName

echo "Clone vagrant scripts"
cd $installDir
git clone git@github.com:starsinmypockets/node-dev-vagrant.git $projName

cd $projName
echo "Remove default app directory"
rm -rf app

echo "Clone clinch build repository"
git clone git@github.com:starsinmypockets/twf.git app
