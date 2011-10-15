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
if [ ! -f $RBENV_ROOT/bin/rbenv ] ; then
  git clone git://github.com/sstephenson/rbenv.git $RBENV_ROOT
fi

# Install rbenv plugins:
if [ ! -d $RBENV_ROOT/plugins/rbenv-vars ] ; then
  git clone git://github.com/sstephenson/rbenv-vars.git $RBENV_ROOT/plugins/rbenv-vars
fi

# Add rbenv to the path:
cat << EOF > $PROFILE
# rbenv setup
export RBENV_ROOT="$RBENV_ROOT"
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

# Rehash:
rbenv rehash
