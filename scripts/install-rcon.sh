#! /usr/bin/bash
wget https://github.com/gorcon/rcon-cli/releases/download/v0.10.3/rcon-0.10.3-amd64_linux.tar.gz
tar xvzf rcon-0.10.3-amd64_linux.tar.gz
sudo mv rcon-0.10.3-amd64_linux/rcon /usr/local/bin/
rm -rf rcon*
sudo chmod a+x /usr/local/bin/rcon
