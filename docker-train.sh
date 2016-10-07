#!/bin/bash

. $RYU_HOME/docker-env.sh

rm -rf state/$tag.v/model
mkdir -p state/$tag.v/model

nvidia-docker run -v $RYU_HOME/state/$tag.v/prep:/preprocessedData:ro -v $RYU_HOME/state/$tag.v/model:/modelState $name /train.sh

echo ====
du -sh state/$tag.v/model
