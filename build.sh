#!/bin/bash
#!/usr/bin/bash

cd $HOME/$PROJECT_DIR

yarn install

yarn build

#npm install

#npm build

sudo rm -rf /var/www/html/*

sudo mv build/* /var/www/html

sudo systemctl restart nginx