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
if [ ! -d "$RBENV_ROOT" ] ; then
  git clone git://github.com/sstephenson/rbenv.git $RBENV_ROOT
else
  pushd $RBENV_ROOT; git pull; popd
fi

# Install rbenv-vars:
RBENV_VARS_ROOT="${RBENV_ROOT}/plugins/rbenv-vars"
if [ ! -d "$RBENV_VARS_ROOT" ] ; then
  git clone git://github.com/sstephenson/rbenv-vars.git $RBENV_VARS_ROOT
else
  pushd $RBENV_VARS_ROOT; git pull; popd
fi

# Install rbenv-gemset:
RBENV_GEMSET_ROOT="${RBENV_ROOT}/plugins/rbenv-gemset"
if [ ! -d $RBENV_GEMSET_ROOT ] ; then
  git clone git://github.com/jamis/rbenv-gemset.git $RBENV_GEMSET_ROOT
else
  pushd $RBENV_GEMSET_ROOT; git pull; popd
fi

# Install rbenv-each:
RBENV_EACH_ROOT="${RBENV_ROOT}/plugins/rbenv-each"
if [ ! -d $RBENV_EACH_ROOT ] ; then
  git clone git://github.com/chriseppstein/rbenv-each.git $RBENV_EACH_ROOT
else
  pushd $RBENV_EACH_ROOT; git pull; popd
fi

# Install rbenv-bundler:
RBENV_BUNDLER_ROOT="${RBENV_ROOT}/plugins/rbenv-bundler"
if [ ! -d $RBENV_BUNDLER_ROOT ] ; then
  git clone git://github.com/carsomyr/rbenv-bundler.git $RBENV_BUNDLER_ROOT
else
  pushd $RBENV_BUNDLER_ROOT; git pull; popd
fi

# Install ruby-build:
if [ ! -d "$RUBY_BUILD_ROOT" ] ; then
  git clone git://github.com/sstephenson/ruby-build.git $RUBY_BUILD_ROOT
else
  pushd $RUBY_BUILD_ROOT; git pull; popd
fi

if [ ! -f "$PROFILE" ] ; then
  # Add rbenv to the path:
  cat << EOF > $PROFILE
# rbenv setup
export RBENV_ROOT="$RBENV_ROOT"
export PATH="$RBENV_ROOT/bin:$RUBY_BUILD_ROOT/bin:\$PATH"
eval "\$(rbenv init -)"
EOF
fi
