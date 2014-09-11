#!/bin/bash

cd /Users/ethanwilkins/Documents/GitHub/

rm -rf elheroe/*

cp -r /Users/ethanwilkins/Documents/ruby/rails/elheroe/ /Users/ethanwilkins/Documents/GitHub/elheroe/

cd /Users/ethanwilkins/Documents/GitHub/elheroe

echo -e "\nCOMMITTING NOW\n"

git add -A

git commit -m "$1"

git push

echo -e "\nDONE COMMITTING\n"