#!/bin/bash

function ok() {
  echo "OK"
}

function fail() {
  echo "FAIL"
  exit
}

function update_repos() {
  printf "Updating System: " && sudo apt update &> /dev/null && ok || fail
}

function install_commons() {
  printf "Install Python SW properties: " && sudo apt-get install -y python-software-properties &> /dev/null && ok || fail
  printf "Install htop: " && sudo apt install -y htop &> /dev/null && ok || fail
  printf "Install git: " && sudo apt install -y git &> /dev/null && ok || fail
  printf "Install cURL: " && sudo apt install -y curl &> /dev/null && ok || fail
  printf "Install trickle: " && sudo apt install -y trickle &> /dev/null && ok || fail
}

echo "Bootstraping..."

update_repos \
&& install_commons
