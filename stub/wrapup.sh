#!/bin/bash

cd $RYU_STATE
tar jcf log.tar.bz2 $LOG_DIR >& /dev/null
echo AAAAAAAAAA
base64 < log.tar.bz2 | tee log.base64
echo BBBBBBBBBB

