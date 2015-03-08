#!/bin/sh

# for mac only

cd ~/Code/GitHub/elheroe/

echo "\nUpdating...\n"

git fetch --all

git reset --hard origin/master

echo "\nCopying...\n"

cp -r ~/Code/GitHub/elheroe/ ~/Code/rails/elheroe/

cd ~/Code/rails/elheroe/

rm -rf .git && rm -rf .gitignore
