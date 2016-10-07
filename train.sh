#!/bin/bash

. $RYU_HOME/env.sh

rm -rf $RYU_MODEL_DIR/*

stub/train.sh

echo "===="
du -sh $RYU_MODEL_DIR
