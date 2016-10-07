#!/bin/sh

df -h > $LOG_DIR/df
find $DATA_DIR/ | head -n 100 > $LOG_DIR/data_dir.list
wc $META_DIR/*  > $LOG_DIR/meta_dir.list
head -n 15000 $META_DIR/exams_metadata_pilot.tsv > $LOG_DIR/15000


