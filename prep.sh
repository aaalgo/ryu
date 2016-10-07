#!/bin/bash

. $RYU_HOME/env.sh

rm -rf $RYU_PREP_DIR/*

stub/preprocess.sh

echo "===="
du -sh $RYU_PREP_DIR
