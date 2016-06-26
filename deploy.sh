#!/bin/bash

# Travis deploy script adapted from
# http://lexi-lambda.github.io/blog/2015/07/18/automatically-deploying-a-frog-powered-blog-to-github-pages/

if [ -d "gh-pages" ]; then
    >&2 echo "Naming conflict. Either rename the folder 'gh-pages' or update the deploy script."
fi

BUILD_DIR=build/docs

set -ev # exit with nonzero exit code if anything fails

# Make sure there's no build directory already
rm -rf $BUILD_DIR || exit 0;

# build blog
npm install
make

# Fetch gh-pages branch
git checkout --quiet -b gh-pages "https://${GH_TOKEN}@${GH_REF}" gh-pages > /dev/null 2>&1

# Remove any previous build and add the new one
rm -rf "gh-pages/${TRAVIS_BRANCH}" || exit 0;
mv $BUILD_DIR "gh-pages/${TRAVIS_BRANCH}"

# Commit the new build
cd gh-pages

git config user.name "Travis CI"
# Email here needs to be the same as the user who created
# the Github access token for Travis
git config user.email "peblairman@gmail.com"

git add -A "${TRAVIS_BRANCH}"
git commit -m "Deploy ${TRAVIS_BRANCH} build to Github Pages"

# Push the new build
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" gh-pages > /dev/null 2>&1
