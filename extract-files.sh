#!/bin/sh

VENDOR=lge
DEVICE=mako

BASE=proprietary
rm -rf $BASE/*

for FILE in `cat proprietary-blobs.txt | grep -v ^# | grep -v ^$ | sed -e 's#^/system/##g'`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    cp ./rom/system/$FILE $BASE/$FILE
done

./setup-makefiles.sh
