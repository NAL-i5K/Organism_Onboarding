#!/bin/sh

#Assuming two things already install
#1. python 
#2. pip

echo "[Step1.] Clone all the remote repos to local"
#apollo2_data_processing needed
#faToTwoBit
#samtools
#jbrowse, https://github.com/GMOD/jbrowse
#wiggle-tool

#django needed
#git clone https://github.com/NAL-i5K/genomics-workspace.git

echo
echo "[Step2.] Setup python environment"
#PYTHON=$(which python)
pip install pipenv

#Locate the Pipfile, create a new virtual environment and install the necessary packages.
pipenv install  

# Activate the virtual environment"
pipenv shell

echo 
echo "[Finish] Let's start editting job-[gggsss].yml before running " ```cwl-runner```


