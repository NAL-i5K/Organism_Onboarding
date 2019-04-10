#Still under dev

echo "[Step1.] Setup python virtual env and activate"
#PYTHON=$(which python)

pip install virtualenv
virtualenv -p python env #Use python in $PATH
cd env/bin/
source activate

echo "[Step2.] Install all the python dependencies"
#pip install cwlref-runner

echo "Finish setting up CWL"


