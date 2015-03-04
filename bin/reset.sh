#!/bin/bash

cd ~/Code/GitHub/elheroe/

echo -e "\nUpdating...\n"

git fetch --all

git reset --hard origin/master

echo -e "Copying...\n"

cp -r ~/Code/GitHub/elheroe/ ~/Code/rails/elheroe/

cd ~/Code/rails/elheroe/

rm -rf .git && rm -rf .gitignore