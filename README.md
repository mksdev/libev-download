# libev mirror scripts

To create your own mirror you need crap cvs tool. 

## libev raw mirror

1. clone and build https://github.com/rcls/crap
2. edit `mirror_cvs.sh`, change variable `REPO_GIT` to your own.
3. run `mirror_cvs.sh` (`crap-clone` built from `crap` repo is expected to be in PATH variable)

## libev release repository

1. run `download_releases.sh`, script gets all released tar files from http://dist.schmorp.de/libev/Attic/
2. edit `update_releases.sh`, change variable `REPO_GIT` to your own
3. run `update_releases.sh`, script checks tags in the repository if they match names of downloaded files. If version is missing script will unpack tar file and pushes corresponding tag to the repository.