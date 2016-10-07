tag=$1

if [ -z "$tag" ]
then
    echo need a tag
fi

cd $RYU_HOME

RYU_DATA_DIR=$RYU_HOME/pilot
RYU_PREP_DIR=$RYU_HOME/state/$tag/prep
RYU_MODEL_DIR=$RYU_HOME/state/$tag/model
RYU_WORKSPACE=$RYU_HOME/state/$tag
export RYU_DATA_DIR
export RYU_PREP_DIR
export RYU_MODEL_DIR
export RYU_WORKSPACE

mkdir -p $RYU_WORKSPACE
mkdir -p $RYU_PREP_DIR
mkdir -p $RYU_MODEL_DIR

