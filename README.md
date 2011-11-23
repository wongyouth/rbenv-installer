# rbenv install

Install/Update [rbenv] and friends by running:

    bash < <(curl -s https://raw.github.com/fesplugas/rbenv-installer/master/rbenv-installer.sh)

Reload the environment:

    $ # If you are not root!
    $ source ~/.bash_profile
    $ # If you are root!
    $ source /etc/profile.d/rbenv.sh

Install Ruby 1.9.3-p0 and make it global:

    rbenv install 1.9.3-p0
    rbenv global 1.9.3-p0

**rbenv** source code is available at <https://github.com/sstephenson/rbenv>

[rbenv]: https://github.com/sstephenson/rbenv
