#!/bin/bash

good=1
if [ ! -e dmdc ]
then
    echo dmdc directory not found, you need to create/symlink it.
    good=
fi
if [ -z "$RYU_HOME" ]
then
    echo 'Environment variable RYU_HOME should be set so that $RYU_HOME/init.sh is this file.'
    good=
fi
if [ -z "$SYNAPSE_ID" ]
then
    echo "Environment variable SYNAPSE_ID should be your project ID"
    good=
fi
if docker --version >& /dev/null ; then true ; else
    echo missing docker
    echo "https://docs.docker.com/engine/installation/"
    good=
fi
if nvidia-docker --version >& /dev/null ; then true; else
    echo "missing nvidia-docker"
    echo "https://github.com/NVIDIA/nvidia-docker"
    good=
fi
if python3 --version >& /dev/null ; then true; else
    echo "missing python3"
    good=
fi
if virtualenv --version >& /dev/null ; then true; else
    echo "missing virtualenv"
    good=
fi

if [ -z "$good" ]
then
    echo "failed to initialize."
    exit
fi

cd $RYU_HOME

if [ ! -d env ]
then
    virtualenv -p python3 env
    . env/bin/activate
    pip install synapseclient
else
    . env/bin/activate
fi

echo "Logging into synapse"
synapse login --rememberMe
echo 
echo "Logging into docker.synapse.org"
echo "Use the same login credential as above"
docker login docker.synapse.org

