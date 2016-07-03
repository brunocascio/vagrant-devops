#!/bin/bash

function ok() {
  echo "OK"
}

function fail() {
  echo "FAIL"
}

function install_docker() {
  printf "Installing Docker: "
  (
    wget -qO- https://get.docker.com/ | sudo bash \
      && sudo usermod -aG docker vagrant
  ) > /dev/null && ok || fail
}

function install_docker_compose() {
  printf "Installing Docker Compose: "
  (
    sudo apt-get -y install python-pip \
      && sudo pip install docker-compose
  ) > /dev/null && ok || fail
}

install_docker && install_docker_compose \
&& echo "alias dc=\"docker-compose\"" >> /home/vagrant/.bash_aliases
