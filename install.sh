#!/bin/bash

set -e
set -u
set -x

# packages you'll need (plus some useful stuff)
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y zsh git openssl libqt4-dev \
 autoconf bison build-essential libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev libffi-dev \
 nodejs

# install configs you like
# relog

# install redis
wget -nc -c http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
# tests are boring, but maybe you like to run them, so...
false && sudo apt-get install -y tcl && make test
cd

# install rbenv (adapt if you use bash)
[[ -d ~/.rbenv ]] || git clone 'https://github.com/sstephenson/rbenv.git' ~/.rbenv
echo '# sunlight' | tee -a ~/.zshrc ~/.bashrc
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' | tee -a ~/.zshrc ~/.bashrc
echo 'eval "$(rbenv init -)"' | tee -a ~/.zshrc ~/.bashrc
[[ -d ~/.rbenv/plugins/ruby-build ]] || git clone 'https://github.com/sstephenson/ruby-build.git' ~/.rbenv/plugins/ruby-build
source ~/.bashrc
# install ruby
rbenv install 2.2.2
rbenv rehash
rbenv global 2.2.2
rbenv shell 2.2.2
rbenv rehash

#install Cassandra

# clone Sunlight
git clone 'https://github.com/columbia/sunlight.git'
gem install bundle
rbenv rehash
# install gems
bundle install
