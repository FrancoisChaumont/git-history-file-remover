#!/bin/bash

# USAGE
#   /bin/bash remove-files-from-git-history.sh ACCOUNT REPOSITORY FILE

# Github account
ACCOUNT=$1
# repository name without extension
REPOSITORY=$2
# file to remove
FILE=$3

url="git@github.com:$ACCOUNT"
repo="$REPOSITORY"
file_to_remove="$FILE"

# path to bfg repo cleaner
bfg_path="bfg-1.14.0.jar"

# clone repo
git clone --mirror $url/$repo.git

# remove files (not physically)
java -jar $bfg_path --no-blob-protection --delete-files $file_to_remove $repo.git/ || exit

# move into repo directory
cd "$repo.git" || exit

# strip out unwanted history 
git reflog expire --expire=now --all && git gc --prune=now --aggressive

# push changes
git push

