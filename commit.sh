#!/bin/bash

cp -r /Users/ethanwilkins/Documents/ruby/rails/newspaper/ /Users/ethanwilkins/Documents/GitHub/newspaper/

cd /Users/ethanwilkins/Documents/GitHub/newspaper

echo "\nCOMMITTING NOW\n"

git add -A

git commit -m "$1"

git push

echo "\nDONE COMMITTING\n"