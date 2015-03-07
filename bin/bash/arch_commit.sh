#!/bin/bash

echo -e "Committing...\n"

git add -A

git commit -m "$1"

git push

echo -e "\n"
