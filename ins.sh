export MAMBARC=.mambarc

curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge-pypy3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -b

source miniforge-pypy3/bin/activate
python install_tools.py
