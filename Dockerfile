FROM tensorflow/tensorflow:0.9.0-gpu
MAINTAINER Wei Dong <wdong@wdong.org>

# Prepare for the Digital Mammography DREAM Challenge
RUN pip install --upgrade pip
RUN pip install pydicom
#RUN pip install -U scikit-learn
#RUN pip install tflearn #git+https://github.com/tflearn/tflearn.git

ADD dmdc /dmdc
ADD stub /stub
ADD stub/train.sh stub/preprocess.sh /
WORKDIR /
#COPY DREAM_DM_starter_tf.py .
#COPY train.sh .
#COPY test.sh .
#COPY score_sc1.sh .
