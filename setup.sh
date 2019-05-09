#!/bin/sh

#We assuming that data wrangler has two things already install
#1. python 
#2. pip

echo "[Step1.] Clone all the remote repos to local"
git clone https://github.com/r06942072/pro_emoji.git

echo
echo "[Step2.] Installing pipenv for python environment"
#PYTHON=$(which python)
pip install pipenv

echo 
echo "[Step3.] Install all the python dependencies by pipenv"
pip install cwltool
#django

echo 
echo "[Step4.] Activate the virtual environment"
pipenv shell

echo 
echo "[Finish] Let's start editting job-[gggsss].yml before we run cwl-runner"


