#!/bin/zsh

REPO_NAME=libev
REPO_GIT=git@github.com:mksdev/libev.git

# wget download folder
PACKAGE_FOLDER=dist.schmorp.de/libev/Attic

if [ -d "./$REPO_NAME" ] 
then
    cd $REPO_NAME
    git pull
    cd ..
else
    git clone $REPO_GIT $REPO_NAME
fi

for fi in $PACKAGE_FOLDER/libev-*.tar.gz; do
	# remove path prefix
	FILENAME=${fi//"${PACKAGE_FOLDER}\/"/""}
	# get folder name (folder that is created from archive extraction)
    FOLDER=${FILENAME//".tar.gz"/""}
    #echo $FOLDER
    VERSION=${FOLDER//"libev-"/""}
    #echo $VERSION
    echo "[$fi] processing $FILENAME, folder $FOLDER, version $VERSION"

    cd $REPO_NAME
    if git rev-parse v$VERSION >/dev/null 2>&1
	then
	    echo "skipping $FOLDER tag v$VERSION found"
	    cd ..
	    continue
	fi
	# remove all files from repository
    git rm -r *
    cd ..

    # extract package, this will extract package into current directory 
    # (not directory in which package is located) 
    tar -zxf $fi
    cp ./$FOLDER/* ./$REPO_NAME
    rm -rf ./$FOLDER

    # commit new version files to the repo
    cd $REPO_NAME
    git add .
	git commit -m "version $VERSION"
	git tag v$VERSION
	git push origin master
	git push --tags origin
	cd ..
done