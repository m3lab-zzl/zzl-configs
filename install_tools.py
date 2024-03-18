from os import getenv
"""Automatically install softwares to reduce work on other computers @zzl """
import os
from shutil import which

if os.getenv("MAMBARC") == None:
    raise ValueError('please run "export MAMBARC=.mambarc" and rerun this script')
else:
    print(os.getenv("MAMBARC"))


def run(cmd: str):
    print("--> ", cmd)
    os.system(cmd)


# -> mamba install packages
mic = "mamba install -c conda-forge -y"
package_exe = {
    "bpytop": "bpytop",  # beautiful top
    "nvim": "nvim",  # neovim
    "lazygit": "lazygit",
    "nodejs": "node",
    "fd-find": "fd",  # improved find
    "ripgrep": "ripgrep",  # live grep
    "fzf": "fzf",  # fuzzy finder
    "jq": "jq",  # json cli processor
    "bat": "bat",  # improved cat
    "tmux": "tmux",
    "tldr": "tldr",  # too long dont read
    "tree": "tree",  # show directory tree
    "gcc": "gcc", # new installed terminal may has no c compiler, which will stop the zsh
    "make": "make", 
    "dos2unix": "dos2unix", 
}
to_ins = ["git"]
for pac, exe in package_exe.items():
    if not which(exe):
        to_ins.append(pac)

run(f"{mic} {' '.join(to_ins)}")

this_dir = os.path.dirname(__file__)
if os.path.islink(f"{this_dir}/bin/nvim"):
    run(f"rm {this_dir}/bin/nvim")
nvimp = which("nvim")
run(f"ln -s {nvimp} {this_dir}/bin/nvim")

print("Linking nvim folder to ~/.config/nvim")
run("mv ~/.config/nvim{,.bak}")
run(f"cp -rf {this_dir}/nvim ~/.config/nvim")

# -> other
if os.path.isfile(".git/config"):
    run("mv .git/config .git/config.bak")
run("cp git_config_template .git/config")
run(
    'git config --global url."https://gitclone.com/github.com/".insteadOf "https://github.com/"'
)
run('git config --global user.name "$(whoami)"')
run('git config --global user.email "$(whoami)@$(hostname)"')
run('git config --global core.autocrlf true')

if os.popen("echo $SHELL").read().strip() == "/bin/zsh":
    run(f"zsh {this_dir}/zsh_conf.sh")
    cmd = "npm install -g neovim pyright && pip install neovim -U"
    run(cmd)
else:
    run(f"bash {this_dir}/bash_conf_zsh.sh")
run(f"find {this_dir}/.omz -type f -print0 | xargs -0 dos2unix --")
