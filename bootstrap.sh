#!/usr/bin/env bash

# Update, install development tools and git:
sudo apt-get update
sudo apt-get -y install build-essential
sudo apt-get -y install git-core

# Extras for RubyGems and Rails:
sudo apt-get -y install zlib1g-dev libssl-dev

# Readline Dev on Ubuntu 10.04 LTS:
sudo apt-get -y install libreadline5-dev

# Readline Dev on Ubuntu 11.10:
# sudo apt-get -y install libreadline-gplv2-dev
