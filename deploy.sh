#!/bin/bash

SHORT_COMMIT=`echo $TRAVIS_COMMIT | cut -c1-7`
VERSION=$SHORT_COMMIT
BRANCH=$TRAVIS_BRANCH
npm install
make

tar czf build/docs.tgz build/docs

# NOTE(joe):
#
# The "*" in front of dele makes the copy continue if the command fails.  This
# makes it so new branches don't need to have someone manually make a file to
# delete (see the -Q option in `man curl`).
#
# We copy the file into a version with the "-copy" suffix, and then move it
# over, so that commands that poll on the server won't process a
# partially-copied file.  Note that the moving commands act as if the ftp
# command has moved into the pyret-docs/$BRANCH directory

curl -u $FTP_USER:$FTP_PASS \
     -Q "*dele pyret-docs/$BRANCH/docs-copy.tgz"\
     -Q "-rnfr docs-copy.tgz"\
     -Q "-rnto docs.tgz"\
     --ftp-create-dirs \
     -T build/docs.tgz ftp://ftp.cs.brown.edu/pyret-docs/$BRANCH/docs-copy.tgz

