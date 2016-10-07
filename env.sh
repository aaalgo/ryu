tag=$1

if [ -z "$tag" ]
then
    echo need a tag
fi

cd $RYU_HOME

RYU_DATA_DIR=$RYU_HOME/pilot
RYU_STATE=$RYU_HOME/state/$tag
RYU_PREP_DIR=$RYU_STATE/prep
RYU_MODEL_DIR=$RYU_STATE/model
mkdir -p $RYU_STATE
mkdir -p $RYU_PREP_DIR
mkdir -p $RYU_MODEL_DIR
export RYU_STATE
export RYU_DATA_DIR
export RYU_PREP_DIR
export RYU_MODEL_DIR

