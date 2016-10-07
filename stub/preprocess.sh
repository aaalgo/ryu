#!/bin/bash

. $RYU_HOME/stub/env.sh

./preprocess.sh 2>&1 | tee $RYU_STATE/log.txt

$RYU_HOME/stub/wrapup.sh
