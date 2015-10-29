#!/bin/bash

VERSION=$(cat ruby-version)
USER="tjinjin"
REPO="automate-ruby-rpm"

# create description

# create release
github-release release \
  --user tjinjin \
  --repo automate-ruby-rpm \
  --tag $VERSION \
  --name "Ruby-$VERSION" \
  --description "not release"

# upload files
for i in $(ls -1 *.rpm)
do
  echo "* $i" >> description.md
  echo "  * $(openssl sha256 $i)" >> description.md
  github-release upload --user tjinjin \
    --repo automate-ruby-rpm \
    --tag $VERSION \
    --name "$i" \
    --file $i
done

# edit description
github-release edit \
  --user $USER \
  --repo $REPO \
  --tag $VERSION \
  --description "$(cat description.md)"
