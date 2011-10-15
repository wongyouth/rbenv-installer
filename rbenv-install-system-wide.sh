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
RBENV_ROOT=/usr/local/rbenv

# Install rbenv:
sudo git clone git://github.com/sstephenson/rbenv.git $RBENV_ROOT

# Install rbenv plugins:
sudo git clone git://github.com/sstephenson/rbenv-vars.git $RBENV_ROOT/plugins/rbenv-vars

# Add rbenv to the path:
sudo cat << EOF > /etc/profile.d/rbenv.sh
# rbenv setup
export RBENV_ROOT="\$RBENV_ROOT"
export PATH="\$RBENV_ROOT/bin:\$PATH"
eval "\$(rbenv init -)"
EOF

# Reload the environment:
sudo chmod +x /etc/profile.d/rbenv.sh
sudo source /etc/profile.d/rbenv.sh

# Install ruby-build:
pushd $(mktemp -d /tmp/ruby-build.XXXXXXXXXX)
  git clone git://github.com/sstephenson/ruby-build.git
  cd ruby-build
  sudo ./install.sh
popd

# Install Ruby 1.9.2-p290:
sudo rbenv install 1.9.2-p290
sudo rbenv global 1.9.2-p290

# Rehash:
sudo rbenv rehash
