#Still under dev

echo "[Step1.] Clone all the remote repos to local"

echo "[Step2.] Setup pipenv and activate"
#PYTHON=$(which python)

pip install virtualenv
virtualenv -p python env #Use python in $PATH
cd env/bin/
source activate

echo "[Step3.] Install all the python dependencies"
#pip install cwlref-runner

echo "Finish setting up CWL"


