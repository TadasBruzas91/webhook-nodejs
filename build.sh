#!/bin/bash
#!/usr/bin/bash

set -e

cd $HOME/cproject/directory # Repository path

yarn install

yarn build

#npm install

#npm build

sudo rm -rf /var/www/html/*

sudo mv build/* /var/www/html

sudo systemctl restart nginx
