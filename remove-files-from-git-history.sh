#!/bin/bash

url="git@github.com:ACCOUNT"
repo="repo-name-without-extension"
bfg_path="/usr/local/bin/bfg.jar"
files_to_remove="file_name"

# clone repo
git clone --mirror $url/$repo.git

# remove files (not physically)
java -jar $bfg_path --no-blob-protection --delete-files $files_to_remove $repo.git/

# move into repo directory
cd $repo.git

# strip out unwanted history 
git reflog expire --expire=now --all && git gc --prune=now --aggressive

# push changes
git push

