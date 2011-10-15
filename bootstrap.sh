#!/usr/bin/env bash

# Update, upgrade and install development tools:
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install build-essential
sudo apt-get -y install git-core

# Extras for RubyGems and Rails:
sudo apt-get -y install zlib1g-dev
sudo apt-get -y install libssl-dev libsqlite3-dev
sudo apt-get -y install libreadline5-dev
