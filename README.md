Ryu: SDK for the DREAM Mammography Challenge
============================================

# Introduction

This SDK is to ease the participation of
[the DREAM Mammography Challenge](https://www.synapse.org/#!Synapse:syn4224222)
by providing the following:

- A unified interface to test algorithms on host and in docker.
- Automation of model submission, with some git integration.
- A more flexible mechanism to send back a small directory of log files.

Ryu assumes the preprocessing-training workflow.


# Installation

This software depends on the following packages:

- python3 and virtualenv
- git
- docker: https://docs.docker.com/engine/installation/
- nvidia-docker: https://github.com/NVIDIA/nvidia-docker

And of course you'll need all the cuda and deep learning software setup on your host.

You'll need to export two environment variables:

- `RYU_HOME`: where you clone this repository, `$RYU_HOME/README.md` should be this file.
- `SYNAPSE_ID`: your synapse project ID (synXXXXXXX). This project should be shared with the user "dmchallengeit". 

It is suggested that you create a GIT repository for your code.
After you clone the Ryu repository, symbolic-link your code directory to `ryu/dmdc`.
And then run `ryu/init.sh`.


```bash
git clone https://github.com/aaalgo/ryu.git

# edit ~/.bashrc to add environment variable RYU_HOME and SYNAPSE_ID

cd ryu

# link your code to dmdc, or use the command below for testing
# link -s dmdc-sample dmdc  

./init.sh
```

Then you can donwload the pilot data and put them into `ryu/pilot/trainingData`
and `ryu/pilot/metadata`.  These two data will be mounted when the algorithm
is tested within docker.

# Workflow

Your code directory `ryu/dmdc` should contain `train.sh` and `preprocess.sh`.
These two scripts will be invoked by the Ryu stubs. Note that these are not
`/train.sh` and `/process.sh` that the DREAM server directly invokes.
(See Dockerfile).

You can make the following assumption when your scripts are invoked.

- The current directory is `$RYU_HOME/dmdc`.  (Inside docker, `$RYU_HOME` is `""`.)
- `$DATA_DIR` contains training data. (Inside docker, this is `/trainingData`.)
- `$META_DIR` contains meta data. (Inside docker, this is `/metadata`.)
- `$PREP_DIR` contains preprocessing output. (Inside docker, this is `/preprocessedData`.)
- `$MODEL_DIR` contains the model data. (Inside docker, this is `/modelState`.)
- `$LOG_DIR` this is a directory where you can put files to.
- `$WORKSPACE` this is a directory you can save intermediate results.


## Run algorithms on host machine

!!! DO NOT USE root ACCOUNT FOR RUNNING THE WORKFLOW.
!!! YOU HAVE BEEN WARNED.


```bash
cd $RYU_HOME
./prep.sh  tag
./train.sh tag
```
The argument `tag` is to identify different runs.
Data will be saved to directories under `$RYU_HOME/state/$tag`.

## Run algorithms in docker
```bash
cd $RYU_HOME
./docker-prep.sh tag
./docker-train.sh tag
````
Data will be saved to directories under `$RYU_HOME/state/$tag.v`.

You can also use `docker-bash.sh` to open a shell within docker.


# Logging and Data Retrieval

The DREAM workflow restrict data feedback to STDOUT/STDERR output.
This is not the most convenient way of communication.  For
more flexible logging, Ryu allows sending back a small amount of
files using base64 encoding.
After your scripts finish running, all files your put into the
directory `$LOG_DIR` will be packed, compressed, base64-encoded
and printed out from STDOUT.

For example, the sample script `dmdc-sample/preprocess.sh`
collect some system information and data samples:
```
#!/bin/sh

df -h > $LOG_DIR/df
find $DATA_DIR/ | head -n 20 > $LOG_DIR/data_dir.list
head -n 20 $META_DIR/exams_metadata_pilot.tsv > $LOG_DIR/20
```

When run with pilot data, either on host or in docker, it will produce
the following output

```
$ ./prep.sh xxx
AAAAAAAAAA
QlpoOTFBWSZTWefPDUwAA+h/hv7wAIBCAf/lN+degP/33/AAAQAgABhQA97g1qTirg4BKTUaGUyE
81R6npNAGmhkBoMgDJhA1GhoGiNKeoA0AAAAAAABIk0EmU01NNPUZPUAyAAADQDQBzAmJoMJkyZM
jCYJppkYmAIYBJCRpM0jVPU81T9FPUeUxBoNA0NGgANqdIfb3adPFzJqwhYDJA1gCRLLbtgCFZkF
el9tbBUDpg0JNEDExg0cSMuPN5VQqrDShCYkxMYD3RA2IJg1OaWbgpVCpCo6Sk0EKrq6uu7KlGk2
km3dEIE4CEyIUDbbE2ANqhZuFFaYpIVaVoUbxN4i5itZxjGIxFVDc3DDl0UkDbYlDRVlMrBeNVMU
NDffq/cvzm0+2eeZvzInBPC0/PakbSwGsRLGBbp0rTfDckGYMSXpCcHHs4udFgovbCwDYREfGJmY
d3kwYdAi9VAhmFrj9RF3C69jk5HLugBIy5SuRxHDMzmyhNYz29L7bKUhsb7qHA/5yBuv+6nhRKJS
CW/frQZ5LDQBiBikkatbM6QkY2OJYsklOeXnDZQJICntG6e+CeQDaAZ4TAMyN1HilK0zqiZUaJO0
JBViR+du/sOTS3o6/kd7wWCdu04XU1l/V6ywOUEdDOCMU1cHAzf3oZeZmYRpkXSxtrnY1RisHku4
xl0EQbQKVkL0hOGLOaLxesyZJbBVasGFcCK5tWKdQoIphybEpvBk9TDuamKXgG+0gHE9KUYENLLB
gDjxJIyFa4WJKYGRCAJsVPst0DXelMEQS2XNAygUlyNMljDrlbanS9oY0sLSJxNDcSg5s2vcxyPA
ESAnICdFHaNCoIvcJwDlVxwOdE51Qk9eB6alihrrSuetb3Pyt9ztKOXYsmNjKFZaVjKqbkdGCufH
hwta+plkHYCZ1R5OtzEpv3AenOjH351S6XTpGyA/M5Ig8BRuJmDMnQyIu4wba+K1LypGkqqicsq6
PRBJjmdDW+JCoIyQ89UjbArFfea4jLAyssRHIwgxwKZUKoCJXrQpKKC3Kfmz+66K5p/oNF2Q1G1J
EVpB7jcuGwUfyWUDEMlBAIlybqx2CTLBCUrq8JBM5pIUEEmc72cLhc+pCvqoWz+8sy/tMUYMZdq3
ALIUqOOcD/a2qvlOxjt0LhkbEUGY5tCtfwVh2FTltZAQFcifCT2TtHN/K2cIAYHdzMRw5wqLWqKI
e0tRVxDcXpXHZxgJ+oOIZkS9YaicQEg2F5u0amhGmiEv+LuSKcKEhz54amA=
BBBBBBBBBB
====
0	/home/wdong/ryu/state/xxx/prep
```
 
Copy and paste the portion between AAAAAAAAAA and BBBBBBBBBB into 
a file named, say, `hex`.  You can then extract the data with
```bash
$ base64 -d < hex > log.tar.bz2
$ tar jxvf log.tar.bz2
```

Note that all your STDOUT/STDERR log will still be delivered before
this base64-encoded log, and the 1MB limitation applies to the sum of both.
You need to make sure you do not exceed this limitation, or the base64
encoding will be truncated and you'll be able to extract nothing
from your log directory.


# Model Submition

You'll have to add your software to Dockerfile.

After you have tested your model locally, you can submit the model with
```
./docker-submit.sh
```

This will do the following:
- Rebuild and upload the docker image.
- Generate a submission file enqueue that for evaluation.

Your submission will be named trial1-XXX, trial2-XXX, trial3-XXX and so on.
This XXX will be the GIT version of the code reside in `$RYU_HOME/dmdc`, or
empty if GIT is not used.

This script makes model submission easy, so you need to constraint from 
submitting to many models.




