#!/usr/bin/env bash

# Verify Git is installed, otherwise suggest running bootstrap:
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

# Install plugins:
PLUGINS=( "sstephenson:rbenv-vars"
          "sstephenson:ruby-build"
          "jamis:rbenv-gemset"
          "chriseppstein:rbenv-each"
          "carsomyr:rbenv-bundler" )

for plugin in ${PLUGINS[@]} ; do

  KEY=${plugin%%:*}
  VALUE=${plugin#*:}

  RBENV_PLUGIN_ROOT="${RBENV_ROOT}/plugins/$VALUE"
  if [ ! -d "$RBENV_PLUGIN_ROOT" ] ; then
    git clone git://github.com/$KEY/$VALUE.git $RBENV_PLUGIN_ROOT
  else
    pushd $RBENV_PLUGIN_ROOT; git pull; popd
  fi

done

if [ ! -f "$PROFILE" ] ; then
  # Add rbenv to the path:
  cat << EOF > $PROFILE
# rbenv setup
export RBENV_ROOT="$RBENV_ROOT"
export PATH="$RBENV_ROOT/bin:\$PATH"
eval "\$(rbenv init -)"
EOF
fi
