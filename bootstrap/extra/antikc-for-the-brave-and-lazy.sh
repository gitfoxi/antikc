#!/bin/bash

if [ -e ~/antikc ]; then
    echo Looks like you already have something at ~/antikc
    echo To use this script, you\'ll have to move it.
    echo
    echo Cowardly refusing to overwrite your stuff. Bye
    exit
fi

cd ~
wget --no-check-certificate https://github.com/gitfoxi/antikc/archive/master.zip
unzip master
rm master
mv antikc-master antikc
cd antikc
cd bootstrap
./makeall

# TODO: ought to check if these lines are already in .bashrc
# TODO: .bashrc, .profile, .bash_profile -- which one?
echo >> ~/.bashrc
echo source ~/antikc/antikc_env.sh >> ~/.bashrc
source ~/antikc/antikc_env.sh

cd ~/antikc
git init
# If you're working with your own clone then use the URL for your account instead
git remote add origin https://github.com/gitfoxi/antikc
git pull --force origin master
git reset --hard

git submodule init
git submodule update

bash

