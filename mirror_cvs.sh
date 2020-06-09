#!/bin/bash

#mirroring of cvs using crap https://github.com/rcls/crap.git

REPO_NAME=libev
REPO_GIT=git@github.com:mksdev/libev.git

if [ -d "./$REPO_NAME" ] 
then
	cd $REPO_NAME
	git pull
	cd ..
else
	git clone $REPO_GIT $REPO_NAME
fi

cd $REPO_NAME
crap-clone :pserver:anonymous@cvs.schmorp.de/schmorpforge libev
git push --all
cd ..