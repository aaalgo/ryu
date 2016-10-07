tag=$1

good=1
if [ -z "$RYU_HOME" ]
then
    echo "missing environment variable RYU_HOME"
    echo "RYU_HOME should be set so that $$RYU_HOME/init.sh is this file."
    good=
fi
if [ -z "$SYNAPSE_ID" ]
then
    echo "missing environment variable SYNAPSE_ID"
    echo "SYNAPSE_ID should be your project ID"
    good=
fi
if nvidia-docker --version
then
    true
else
    echo "missing nvidia-docker"
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
docker login docker.synapse.org

if [ ! -e dmdc ]
then
    echo dmdc directory not found, you need to create/symlink it.
fi

