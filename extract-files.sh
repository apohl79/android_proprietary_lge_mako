#!/bin/sh

VENDOR=lge
DEVICE=mako

BASE=./proprietary
rm -rf $BASE/*

for FILE in `cat proprietary-blobs.txt | grep -v ^# | grep -v ^$ | sed -e 's#^/system/##g'`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    CS1=$(md5sum $BASE/$FILE 2>/dev/null|awk '{print $1}')
    CS2=$(md5sum ./rom/system/$FILE 2>/dev/null|awk '{print $1}')
    if [ "$CS1" != "$CS2" ]; then
	echo "  $FILE"
	cp ./rom/system/$FILE $BASE/$FILE
    fi
done

./setup-makefiles.sh
