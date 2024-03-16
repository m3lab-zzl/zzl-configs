export MAMBARC=$PWD/.mambarc
if [[ $SHELL == "/bin/zsh" ]]; then
	pref=$HOME/miniforge-pypy3
else
	pref=$PWD/miniforge-pypy3
fi

if [[ -e "Miniforge-pypy3-$(uname)-$(uname -m).sh" ]]; then
	bash Miniforge-pypy3-$(uname)-$(uname -m).sh -b -p $pref
else
	curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge-pypy3-$(uname)-$(uname -m).sh"
	bash Miniforge-pypy3-$(uname)-$(uname -m).sh -b -p $pref
fi

# codon
/bin/bash -c "$(curl -fsSL https://exaloop.io/install.sh)"

source $pref/bin/activate
python install_tools.py
cp zshrc .zshrc
