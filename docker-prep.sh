#!/bin/bash

. $RYU_HOME/docker-env.sh

rm -rf state/$tag.v/prep
mkdir -p state/$tag.v/prep

nvidia-docker run -v $RYU_HOME/pilot/trainingData:/trainingData:ro -v $RYU_HOME/pilot/metadata:/metadata:ro -v $RYU_HOME/state/$tag.v/prep:/preprocessedData $name /preprocess.sh

echo ====
du -sh state/$tag.v/prep
