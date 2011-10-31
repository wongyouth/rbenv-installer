#!/usr/bin/env bash

# We are using Git so verify first if the package is installed:
if [ ! $(which git) ]; then
  echo "Git is not installed."
  exit
fi

# Set where rbenv is going to be installed:
if (( UID == 0 )) ; then
  RBENV_ROOT="/usr/local/rbenv"
  PROFILE="/etc/profile.d/rbenv.sh"
  RUBY_BUILD_ROOT="/usr/local/ruby-build"
else
  RBENV_ROOT="${HOME}/.rbenv"
  PROFILE="${HOME}/.bash_profile"
  RUBY_BUILD_ROOT="${HOME}/.ruby-build"
fi

# Install rbenv:
if [ ! -d $RBENV_ROOT ] ; then
  git clone git://github.com/sstephenson/rbenv.git $RBENV_ROOT
fi

# Install rbenv plugins:
$RBENV_VARS_ROOT="${RBENV_ROOT}/plugins/rbenv-vars"
if [ ! -d $RBENV_VARS_ROOT ] ; then
  git clone git://github.com/sstephenson/rbenv-vars.git $RBENV_VARS_ROOT
fi

# Install ruby-build:
if [ ! -d $RUBY_BUILD_ROOT ] ; then
  git clone git://github.com/sstephenson/ruby-build.git $RUBY_BUILD_ROOT
fi

# Add rbenv to the path:
cat << EOF > $PROFILE
# rbenv setup
export RBENV_ROOT="$RBENV_ROOT"
export PATH="$RBENV_ROOT/bin:$RUBY_BUILD_ROOT/bin:\$PATH"
eval "\$(rbenv init -)"
EOF
