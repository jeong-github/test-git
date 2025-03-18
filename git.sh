#!/bin/bash

echo "git init"
git init

echo "git add"
git add .

# echo "input commit"
read -p "input commit : " Cname
git commit -m $Cname
