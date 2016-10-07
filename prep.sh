#!/bin/bash

. $RYU_HOME/env.sh

mkdir -p $RYU_PREP_DIR
rm -rf $RYU_PREP_DIR/*

stub/preprocess.sh

echo "===="
du -sh $RYU_PREP_DIR
