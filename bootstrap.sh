#!/usr/bin/env bash

# Update, upgrade and install development tools:
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install build-essential
sudo apt-get -y install git-core

# Extras for RubyGems and Rails:
sudo apt-get -y install zlib1g-dev libssl-dev libreadline5-dev
