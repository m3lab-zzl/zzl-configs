export MAMBARC=$PWD/.mambarc
if [[ $SHELL == "/bin/zsh" ]]; then
	pref=$HOME/miniforge-pypy3
else
	pref=$PWD/miniforge-pypy3
fi

# check if mamba is found
if ! command -v mamba &>/dev/null; then
	if [[ -e "Miniforge-pypy3-$(uname)-$(uname -m).sh" ]]; then
		bash Miniforge-pypy3-$(uname)-$(uname -m).sh -b -p $pref
	else
		curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge-pypy3-$(uname)-$(uname -m).sh"
		bash Miniforge-pypy3-$(uname)-$(uname -m).sh -b -p $pref
	fi
fi

# check if entr is found
if ! command -v entr &>/dev/null; then
	tar xf entr-5.5.tar.gz
	cd entr-5.5
	./configure
	make test
	PREFIX=$PWD/entr make install
	rm -rf entr-5.5
fi

source $pref/bin/activate
python install_tools.py
cp zshrc .zshrc
