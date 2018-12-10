#!/usr/bin/env bash

# Based on: https://github.com/stackery/php-lambda-layer/blob/6e269aad2f8e0c63fa5b190ae83cfba0aa634252/build.sh

yum install -y php71-cli zip

mkdir /tmp/layer
cd /tmp/layer
cp /opt/layer/bootstrap .
cp /opt/layer/php.ini .

mkdir bin
cp /usr/bin/php bin/

mkdir lib
for lib in libncurses.so.5 libtinfo.so.5 libpcre.so.0; do
  cp "/lib64/${lib}" lib/
done

cp /usr/lib64/libedit.so.0 lib/

cp -a /usr/lib64/php lib/

zip -r /opt/layer/php71.zip .