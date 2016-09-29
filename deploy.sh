#!/bin/bash

SHORT_COMMIT=`echo $TRAVIS_COMMIT | cut -c1-7`
tar czf build/docs.tgz build/docs
curl --ftp-create-dirs -T build/docs.tgz -u $FTP_USER:$FTP_PASS ftp://ftp.cs.brown.edu/pyret-docs/

