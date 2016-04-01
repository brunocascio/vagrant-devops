#!/usr/bin/env bash

function ok() {
  echo "OK"
}

function fail() {
  echo "FAIL"
  exit
}

function install_mysql() {
  # Force a blank root password for mysql
  sudo echo "mysql-server mysql-server/root_password password " | sudo debconf-set-selections
  sudo echo "mysql-server mysql-server/root_password_again password " | sudo debconf-set-selections

  printf "Installing Mysql: " && (sudo apt install -q -y -f mysql-server mysql-client) &> /dev/null && ok || fail
}

function install_php() {
  printf "Installing PHP: " && (sudo apt install -q -y -f php5-fpm php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcached php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-xcache) &> /dev/null && ok || fail
}

function install_nginx() {
  printf "Installing NGINX: " && (sudo aptitude install -q -y -f nginx \
    && sudo rm /etc/nginx/sites-available/default \
    && sudo cp /vagrant/provisioning/nginx/default /etc/nginx/sites-available/default
  ) &> /dev/null && ok || fail
}

install_mysql \
  && install_php \
    && install_nginx \
      && sudo service php5-fpm restart \
        && sudo service nginx restart
