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

# Set where rbenv is going to be installed:
RBENV_ROOT=$HOME/.rbenv

# Install rbenv:
git clone git://github.com/sstephenson/rbenv.git $RBENV_ROOT

# Install rbenv plugins:
git clone git://github.com/sstephenson/rbenv-vars.git $RBENV_ROOT/plugins/rbenv-vars

# Add rbenv to the path:
cat << EOF >> ~/.bash_profile
# rbenv setup
export RBENV_ROOT="\$RBENV_ROOT"
export PATH="\$RBENV_ROOT/bin:\$PATH"
eval "\$(rbenv init -)"
EOF

# Reload the environment:
source ~/.bash_profile

# Install ruby-build:
pushd $(mktemp -d /tmp/ruby-build.XXXXXXXXXX)
  git clone git://github.com/sstephenson/ruby-build.git
  cd ruby-build
  PREFIX=$RBENV_ROOT ./install.sh
popd

# Install Ruby 1.9.2-p290:
rbenv install 1.9.2-p290
rbenv global 1.9.2-p290

# Rehash:
rbenv rehash
