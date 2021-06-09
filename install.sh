#!/bin/bash
#!/usr/bin/bash

set -e # If error kill script

echo "Start Install..."

mkdir $HOME services && echo "Dir created" || echo "Dir exists"

mkdir $HOME/services webhook-nodejs && echo "Dir created" || echo "Dir exists"

mv index.js build.sh $HOME/services/webhook-nodejs && echo "File moved successfuly"

printf "[Unit]\nDescription=Github webhook\nAfter=network.target\n\n[Service]\nEnvironment=NODE_PORT=8080\nType=simple\nUser=$USER\nExecStart=/usr/bin/node $HOME/services/webhook-nodejs/index.js\nRestart=on-failure\n\n[Install]\nWantedBy=multi-user.target" > webhook.service

sudo mv webhook.service /etc/systemd/system && echo "system dir => $(ls /etc/systemd/system | grep webhook)"

sudo systemctl daemon-reload && echo "Daemon reloaded"

sleep 3 

sudo systemctl enable webhook.service && echo "Enabled cooler.service"

sleep 3

sudo systemctl start webhook.service && echo "Started cooler.service"

sleep 3

sudo systemctl status webhook.service 

echo "Install Done"

