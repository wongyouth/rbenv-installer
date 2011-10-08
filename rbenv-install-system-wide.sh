# Update, upgrade and install development tools:
apt-get update
apt-get -y upgrade
apt-get -y install build-essential
apt-get -y install git-core

# Extras for RubyGems and Rails:
apt-get -y install zlib1g-dev
apt-get -y install libssl-dev libsqlite3-dev
apt-get -y install libreadline5-dev

# Install rbenv:
git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv

# Install rbenv plugins:
git clone git://github.com/sstephenson/rbenv-vars.git /usr/local/rbenv/plugins/rbenv-vars

# Add rbenv to the path:
cat << EOF > /tmp/rbenv.sh
# rbenv setup
export RBENV_ROOT=/usr/local/rbenv
export PATH="\$RBENV_ROOT/bin:\$PATH"
eval "\$(rbenv init -)"
EOF

chmod +x /etc/profile.d/rbenv.sh
source /etc/profile.d/rbenv.sh

# Install ruby-build:
pushd $(mktemp -d /tmp/ruby-build.XXXXXXXXXX)
  git clone git://github.com/sstephenson/ruby-build.git
  cd ruby-build
  ./install.sh
popd

# Install Ruby 1.9.2-p290:
rbenv install 1.9.2-p290
rbenv global 1.9.2-p290

# Rehash:
rbenv rehash