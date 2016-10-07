tag=$1


if [ -z "$SYNAPSE_ID" ]
then
    echo "export SYNAPSE_ID!!"
    exit 1
fi


cd $RYU_HOME

VERSION=


if [ -d src/.git ]
then
    pushd src
    git fetch origin
    if git status | grep behind 
    then
        echo "git is behind, git pull first."
        exit 1
    fi

    VERSION=`git describe --always`
    popd
fi

if [ ! -d env ]
then
    virtualenv -p python3 env
    . env/bin/activate
    pip install synapseclient
else
    . env/bin/activate
fi

if [ -z "$tag" ]
then
    echo "tag not specified, trying to generate one..."
    TMP=`mktemp`
    synapse list $SYNAPSE_ID > $TMP
    echo "existing trials:"
    grep -o 'trial[0-9]\+' $TMP
    for I in `seq 1 1000`
    do
        if grep trial$I $TMP
        then
            continue
        fi
        tag="trial$I-$VERSION"
        break
    done
    echo "tag generated: $tag"
    rm $TMP
fi

if [ -z "$tag" ]
then
    echo "fail to generate tag."
    exit 1
fi
name=docker.synapse.org/$SYNAPSE_ID/$tag

nvidia-docker build -t $name .

ID=`nvidia-docker images -q $name`

if [ -z "$ID" ]
then
    echo missing docker image
    exit 1
fi
