# if CONFIG_DIR is set, use it, otherwise use current folder
Raw=${(%):-%x:h}
SCRIPTPATH=${Raw:h}
if [ -z "$CONFIG_DIR" ]; then
	export CONFIG_DIR=$SCRIPTPATH
fi
export CARGO_HOME=$CONFIG_DIR/.cargo

# proxy and mirror
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"

# PATHs
if [ -d "$SCRIPTPATH/miniforge-pypy3" ]; then
	dire="$SCRIPTPATH/miniforge-pypy3"
else
	dire="$HOME/miniforge3"
fi
export PATH=$PATH:${dire}/bin
export PATH=$PATH:$CONFIG_DIR/bin
export PATH=$PATH:$HOME/.local/bin
export MAMBARC=$CONFIG_DIR/.mambarc

# Alias
alias b='bpytop'
alias c='code'
alias n="XDG_CONFIG_HOME=$CONFIG_DIR nvim"
alias v='vim'
alias l='lazygit'
alias g='gitui'
alias ipy='ipython'
alias tm="tmux -f $CONFIG_DIR/tmux.conf"

alias ll='ls -ohFA'
alias sl='ls -lth'
alias fs='echo "folder size: " && du -sh'
alias vf='vim $(fzf)'
alias vg="vim $CONFIG_DIR/generalSetting.sh"

alias sz='source ~/.zshrc'
alias nz='nvim ~/.zshrc'
alias cz='code ~/.zshrc'

alias tf='tail -f'
alias sq='squeue --format="%.18i %.9P %.20j %.8u %.1T %.9M %.10l %.1D %R" --me'
alias ma='mamba activate'
alias mb='mamba activate base'
alias mde='mamba deactivate'
alias mel='mamba env list'
alias mer='mamba env remove -n'
alias mic='mamba install -c conda-forge -C -y'
alias bi='brew install'
alias pi='pip install -U'
alias pu='pip uninstall'
alias np3='nohup python3 -u'
alias p3='python3 -u' # print instantly
alias py='python3 -u' # print instantly
alias gt='git log --pretty=oneline --abbrev-commit --graph --decorate'
# temporarily disable gitconfig to git push
alias gp="mv ~/.gitconfig ~/.gitconfig-bk ; git push ; mv ~/.gitconfig-bk ~/.gitconfig"
alias rg="echo remove gitconfig; mv ~/.gitconfig ~/.gitconfig-bk"
alias gg='echo get gitconfig; mv ~/.gitconfig-bk ~/.gitconfig'
alias sq='squeue'
alias sb='sbatch'

if [ -x "$(command -v brew)" ]; then
	alias gx='brew update; brew upgrade & mamba update --all -y & omz update & tldr --update'
else
	alias gx='mamba update --all -y & omz update & tldr --update' 
fi

# find file in current folder, including hidden files starts with dot
function ff() {
	echo "\$ find . -name $1"
	find . -name $1
}
# compress file/folder to tar.xz
function ys() {
	echo "XZ_OPT='-T0 -9 -vv' tar cJf $1.tar.xz $1" && XZ_OPT='-T0 -9 -vv' tar cJf $1.tar.xz $1
}
# create conda env and activate it
function cn() {
	local env_name="$1"
	shift
	echo "mamba create -n $env_name $@ -y -C" && mamba create -n "$env_name" -y -C "$@"
	echo "mamba activate $env_name" && mamba activate "$env_name"
}
# show tree, default to level 2
function t() {
	local lev="$1"
	# if no lev is passed, default to 2
	if [ -z "$lev" ]; then
		lev=2
	fi
	tree -L $lev
}
# show available python script base name in $CONFIG_DIR/bin
function pys() {
	# find $CONFIG_DIR/bin -name '*.py'
	find $CONFIG_DIR/bin -name '*.py' | xargs -n 1 basename | sed 's/.py//g'
}
# alias each script base name to run it
for py in $(pys); do
	alias $py="python3 $CONFIG_DIR/bin/$py.py"
done

# others
export CONDA_AUTO_ACTIVATE_BASE=false # do not auto-activate
export JUPYTER_PLATFORM_DIRS=1        # to ignore jupyter warning in pytest

export DISPLAY=localhost:0.0
