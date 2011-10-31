#!/usr/bin/env bash

# Update, upgrade and install development tools:
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install build-essential
sudo apt-get -y install git-core curl

# Extras for RubyGems and Rails:
sudo apt-get -y install zlib1g-dev libssl-dev

# If you are on Ubuntu 10.04 LTS
sudo apt-get -y install libreadline5-dev

# If you are on Ubuntu 11.10:
# sudo apt-get -y install libreadline-gplv2-dev
