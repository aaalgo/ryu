
DATA_DIR=$RYU_DATA_DIR/trainingData
META_DIR=$RYU_DATA_DIR/metadata
PREP_DIR=$RYU_PREP_DIR
MODEL_DIR=$RYU_MODEL_DIR
LOG_DIR=$RYU_STATE/logfiles
WORKSPACE=$RYU_STATE/ws

if [ -z "$PREP_DIR" ]
then
    PREP_DIR=/preprocessedData
fi

if [ -z "$MODEL_DIR" ]
then
    MODEL_DIR=/modelState
fi

mkdir -p $DATA_DIR
mkdir -p $LOG_DIR
mkdir -p $WORKSPACE
DATA_DIR=`readlink -e $DATA_DIR`
META_DIR=`readlink -e $META_DIR`
PREP_DIR=`readlink -e $PREP_DIR`
MODEL_DIR=`readlink -e $MODEL_DIR`
LOG_DIR=`readlink -e $LOG_DIR`
WORKSPACE=`readlink -e $WORKSPACE`
export DATA_DIR
export META_DIR
export PREP_DIR
export MODEL_DIR
export LOG_DIR
export WORKSPACE

rm -rf $LOG_DIR/*

cd $RYU_HOME/dmdc

