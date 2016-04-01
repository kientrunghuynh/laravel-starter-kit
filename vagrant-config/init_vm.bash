#!/bin/bash

apt-get update -y
apt-get remove -y apache2 postgresql postgresql-9.3 memcached mongodb
apt-get autoremove -y
apt-get install -y nginx php5-fpm php5-xdebug php5-mongo redis-server redis-tools supervisor

# nginx config file
cp /vagrant/vagrant-config/nginx-config /etc/nginx/sites-enabled/default
cp /vagrant/vagrant-config/nginx.conf /etc/nginx/nginx.conf
chown root:root /etc/nginx/sites-enabled/default
# xdebug config file
cp /vagrant/vagrant-config/20-xdebug.ini /etc/php5/fpm/conf.d/20-xdebug.ini
chown root:root /etc/php5/fpm/conf.d/20-xdebug.ini
# supervisor config file
cp /vagrant/vagrant-config/worker.conf /etc/supervisor/conf.d/worker.conf
chown root:root /etc/supervisor/conf.d/worker.conf
mkdir -p /var/uploads
chown vagrant:vagrant /var/uploads
chmod -R 777 /var/uploads

service nginx restart
service php5-fpm restart
service supervisor restart
