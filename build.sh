#!/usr/bin/env bash

# Based on: https://github.com/stackery/php-lambda-layer/blob/6e269aad2f8e0c63fa5b190ae83cfba0aa634252/build.sh

yum install -y epel-release yum-utils zip http://rpms.remirepo.net/enterprise/remi-release-6.rpm
yum-config-manager --enable remi-php72
yum update
yum install -y --disablerepo="*" --enablerepo="remi,remi-php72" php-cli libargon2

mkdir /tmp/layer
cd /tmp/layer
cp /opt/layer/bootstrap .
cp /opt/layer/php.ini .
chmod 755 bootstrap

mkdir bin
cp /usr/bin/php bin/

mkdir lib
for lib in libncurses.so.5 libtinfo.so.5 libpcre.so.0; do
  cp "/lib64/${lib}" lib/
done

for lib in libedit.so.0 libargon2.so.0; do
  cp "/usr/lib64/${lib}" lib/
done

cp -a /usr/lib64/php lib/

zip -r /opt/layer/php72.zip .