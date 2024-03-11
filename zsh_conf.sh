echo "export https_proxy=http://127.0.0.1:2333" >> ~/.zshrc
echo "export http_proxy=http://127.0.0.1:2333" >> ~/.zshrc
echo "export all_proxy=socks5://127.0.0.1:2333" >> ~/.zshrc
echo "XDG_CACHE_HOME=$PWD ZDOTDIR=$PWD zsh" >> ~/.zshrc
echo "export https_proxy=http://127.0.0.1:2333"
echo "export http_proxy=http://127.0.0.1:2333"
echo "export all_proxy=socks5://127.0.0.1:2333"

# if omz function is not defined
if [ ! -d ".omz" ]; 
then
    export ZSH=$PWD/.omz
    sh omz_ins.sh
    git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git .omz/custom/themes/powerlevel10k
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git .omz/custom/plugins/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions .omz/custom/plugins/zsh-autosuggestions
    git clone --depth=1 https://github.com/marlonrichert/zsh-autocomplete.git .omz/custom/plugins/zsh-autocomplete
    git clone --depth=1 https://github.com/wting/autojump.git && cd autojump && ./install.py
fi
