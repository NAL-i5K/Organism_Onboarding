#!/bin/sh

#Assuming two things already install
#1. python
#2. pip

echo "[Step1.] Clone all the remote repos to local"
#Step1 aim to download all the things needed from remote to local for Organism Onboarding purpose  

#apollo2_data_processing needed
#faToTwoBit
#samtools
#jbrowse, https://github.com/GMOD/jbrowse
#wiggle-tool

#django needed
#git clone https://github.com/NAL-i5K/genomics-workspace.git

echo
echo "[Step2.] Setup python environment with pipenv"
#Download a package called pipenv by pip  
pip install pipenv

#Using python3 to create a new virtual environment for the Organism Onboarding project  
#Locate the Pipfile, and install the necessary packages.  
pipenv install --three



