#!/bin/bash

ZIP=$1
LOG=$2

if [ -z "$LOG" ]
then
    echo "usage:   dump-log.sh   log.zip   log-dir"
    exit 1
fi

if [ -e "$LOG" ]
then
    echo "$LOG already exists"
    exit 1
fi

mkdir -p $LOG

TMP=`mktemp -d`
ZIP_PATH=`readlink -e $ZIP`
LOG_PATH=`readlink -e $LOG`
pushd $TMP
unzip $ZIP_PATH
txt=`basename $ZIP .zip`.txt
dos2unix $txt
cat $txt | grep '^STDOUT:' | sed 's/^STDOUT: //' | grep -v '^AAAAAAAAAA$' | grep -v '^BBBBBBBBBB$' | base64 -d > log.tar.bz2
tar jxvf log.tar.bz2
mv logfiles/* $LOG_PATH
popd
rm -rf $TMP
