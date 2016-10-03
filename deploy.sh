#!/bin/bash

SHORT_COMMIT=`echo $TRAVIS_COMMIT | cut -c1-7`
VERSION=$SHORT_COMMIT
BRANCH=horizon
npm install
make

tar czf build/docs.tgz build/docs

# NOTE(joe):
#
# The "*" in front of dele makes the copy continue if the command fails.  This
# makes it so new branches don't need to have someone manually make a file to
# delete (see the -Q option in `man curl`).

curl -u $FTP_USER:$FTP_PASS \
     -Q "*dele pyret-docs/$BRANCH/docs.tgz"\
     --ftp-create-dirs \
     -T build/docs.tgz ftp://ftp.cs.brown.edu/pyret-docs/$BRANCH/docs.tgz

