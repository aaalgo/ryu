#!/bin/bash

. $RYU_HOME/docker-env.sh

nvidia-docker push $name 

full_name=`nvidia-docker inspect --format '{{.ID}}' $name`

mkdir -p submit
cat > submit/$tag <<FOO
preprocessing=$name@$full_name
training=$name@$full_name
FOO


synapse submit --parentid $SYNAPSE_ID --name $tag --file submit/$tag  --evaluationName "Digital Mammography Model Training"

