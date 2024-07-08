#!/bin/bash

set -e
set -u

MAX=30

export LANG=C

date

for (( n=1; n<=$MAX; n++ ))
do
  num=`printf %02d $n`
  [ -d /backup/self/$num ] || mkdir -vp /backup/self/$num
done

rm -rf /backup/self/$MAX

for (( n=$MAX; n>1; n-- ))
do
  let src=$n-1
  let dest=$n
  srcNum=`printf %02d $src`
  destNum=`printf %02d $dest`
  mv -v /backup/self/$srcNum /backup/self/$destNum
done

rsync -a -H --delete --xattrs \
--exclude=/backup/ \
--exclude=/dev/ \
--exclude=/media/ \
--exclude=/mnt/ \
--exclude=/proc/ \
--exclude=/run/ \
--exclude=/sys/ \
--exclude=/var/lib/docker/devicemapper/devicemapper/ \
--link-dest=/backup/self/02 \
/ /backup/self/01

touch /backup/self/01

date
