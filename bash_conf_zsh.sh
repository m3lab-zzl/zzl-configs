cp ~/.bashrc ~/.bashrc.bak-zzl
if [ ! -d "zsh_manual" ]; 
then
    mkdir zsh_manual
    zsh_manual_dir=$PWD/zsh_manual
    tar xf zsh-5.9.tar.xz
    cd zsh-5.9
    ./configure --prefix="$zsh_manual_dir" CPPFLAGS="-I$zsh_manual_dir/include" LDFLAGS="-L$zsh_manual_dir/lib"
    make -j && make install
    echo "" >> ~/.bashrc
    echo "export PATH=\$PATH:$zsh_manual_dir/bin" >> ~/.bashrc
    cd ..
    echo "alias zzz='XDG_CACHE_HOME=$PWD ZDOTDIR=$PWD zsh'" >> ~/.bashrc
fi

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
