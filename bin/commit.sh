#!/bin/bash

echo -e "\nCopying...\n"

cd ~/Code/GitHub/

rm -rf elheroe/*

cp -r ~/Code/rails/elheroe/ ~/Code/GitHub/elheroe/

cd ~/Code/GitHub/elheroe

echo -e "Committing...\n"

git add -A

git commit -m "$1"

git push

echo -e "\n"
