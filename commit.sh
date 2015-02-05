#!/bin/bash

echo -e "\nCopying...\n"

cd /Users/ethanwilkins/Documents/GitHub/

rm -rf elheroe/*

cp -r /Users/ethanwilkins/Documents/rails/elheroe/ /Users/ethanwilkins/Documents/GitHub/elheroe/

cd /Users/ethanwilkins/Documents/GitHub/elheroe

echo -e "Committing...\n"

git add -A

git commit -m "$1"

git push

echo -e "\n"

# echo -e "\nLogging on...\n"
#
# ssh root@elheroe.net /home/rails/fresh.sh
