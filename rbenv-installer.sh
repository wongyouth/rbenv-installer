#!/usr/bin/env bash

# Verify Git is installed, otherwise suggest running bootstrap:
if [ ! $(which git) ]; then
  echo "Git is not installed."
  exit
fi

RBENV_ROOT="$HOME/.rbenv"

# Install rbenv:
if [ ! -d "$RBENV_ROOT" ] ; then
  git clone git://github.com/sstephenson/rbenv.git $RBENV_ROOT
else
  pushd $RBENV_ROOT; git pull; popd
fi

# Install plugins:
PLUGINS=( "sstephenson:rbenv-vars"
          "sstephenson:ruby-build" )

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

# Show help if `.rbenv` is not in the path:
if [ ! $(which rbenv) ]; then
  echo "
Seems you still have not added 'rbenv' to the load path:

    if [[ -d \$HOME/.rbenv ]]; then
      export PATH=\"\$HOME/.rbenv/bin:\$PATH\"
      eval \"\$(rbenv init -)\"
    fi
  "
fi
