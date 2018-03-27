#!/bin/bash

SOURCE_DIR=/Users/alex/dev/itpeople
TARGET_DIR=/Users/alex/dev/cratis-cmp/.deploy

rm -rf $TARGET_DIR
git clone git@gitlab.com:negativespace/django-app.git $TARGET_DIR

rm -rf $TARGET_DIR/app
ln -s $SOURCE_DIR $TARGET_DIR/app
ln -s /Users/alex/dev/cratis-cmp/lib $TARGET_DIR/lib