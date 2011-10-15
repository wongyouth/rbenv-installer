#!/usr/bin/env bash

# Set where rbenv is going to be installed:
if (( UID == 0 ))
then
  RBENV_ROOT="/usr/local/rbenv"
  PROFILE="/etc/profile.d/rbenv.sh"
else
  RBENV_ROOT="${HOME}/.rbenv"
  PROFILE="${HOME}/.bash_profile"
fi

# Install rbenv:
git clone git://github.com/sstephenson/rbenv.git $RBENV_ROOT

# Install rbenv plugins:
git clone git://github.com/sstephenson/rbenv-vars.git $RBENV_ROOT/plugins/rbenv-vars

# Add rbenv to the path:
cat << EOF > $PROFILE
# rbenv setup
export RBENV_ROOT="\$RBENV_ROOT"
export PATH="\$RBENV_ROOT/bin:\$PATH"
eval "\$(rbenv init -)"
EOF

# Reload the environment:
if (( UID == 0 ))
then
  chmod +x $PROFILE
fi
source $PROFILE

# Install ruby-build:
pushd $(mktemp -d /tmp/ruby-build.XXXXXXXXXX)
  git clone git://github.com/sstephenson/ruby-build.git
  cd ruby-build
  PREFIX=$RBENV_ROOT ./install.sh
popd

# Install Ruby 1.9.2-p290 and make it global:
rbenv install 1.9.2-p290
rbenv global 1.9.2-p290

# Rehash:
rbenv rehash
