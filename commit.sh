#!/bin/bash

cd /Users/ethanwilkins/Documents/GitHub/

rm -rf newspaper/*

cp -r /Users/ethanwilkins/Documents/ruby/rails/newspaper/ /Users/ethanwilkins/Documents/GitHub/newspaper/

cd /Users/ethanwilkins/Documents/GitHub/newspaper

echo -e "\nCOMMITTING NOW\n"

git add -A

git commit -m "$1"

git push

echo -e "\nDONE COMMITTING\n"