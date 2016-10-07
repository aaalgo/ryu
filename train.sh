#!/bin/bash

. $RYU_HOME/env.sh

mkdir -p $RYU_MODEL_DIR
rm -rf $RYU_MODEL_DIR/*

stub/train.sh

echo "===="
du -sh $RYU_MODEL_DIR
