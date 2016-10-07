#!/bin/sh

. $RYU_HOME/stub/env.sh

dmdc/preprocess.sh 2>&1 | tee log.txt

cd $RYU_WORKSPACE
tar jcf log.tar.bz2 $LOG_DIR
echo AAAAAAAAAA
base64 < log.tar.bz2
echo BBBBBBBBBB


