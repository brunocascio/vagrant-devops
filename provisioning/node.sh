#!/bin/bash

function ok() {
  echo "OK"
}

function fail() {
  echo "FAIL"
  exit
}

function install_nvm() {
  printf "Installing nvm: " && (
  curl https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
  ) &> /dev/null && ok || fail

  echo "source /home/vagrant/.nvm/nvm.sh" >> /home/vagrant/.profile
  source /home/vagrant/.profile

  printf "Installing node and npm latest: " && (
    nvm install 5.9 \
    && nvm alias default 5.9 \
    && nvm use default
  ) &> /dev/null && ok || fail
}

install_nvm
