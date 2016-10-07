#!/bin/sh

. $RYU_HOME/stub/env.sh

dmdc/train.sh 2>&1 | tee $RYU_WORKSPACE/log.txt

cd $RYU_WORKSPACE
tar jcf log.tar.bz2 $LOG_DIR >& /dev/null
echo AAAAAAAAAA
base64 < log.tar.bz2
echo BBBBBBBBBB

