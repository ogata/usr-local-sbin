#!/bin/bash

set -e
set -u

MAX=30

export LANG=C

date

for (( n=1; n<=$MAX; n++ ))
do
  [ -d /backup/self/$n ] || mkdir -vp /backup/self/$n
done

rm -rf /backup/self/$MAX

for (( n=$MAX; n>1; n-- ))
do
  let src=$n-1
  let dest=$n
  mv -v /backup/self/$src /backup/self/$dest
done

rsync -a -H --delete    \
--exclude=/backup/      \
--exclude=/dev/         \
--exclude=/proc/        \
--exclude=/sys/         \
--exclude=/swapfile             \
--link-dest=/backup/self/2   \
/    /backup/self/1

touch /backup/self/1

date
