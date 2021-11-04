#! /bin/bash

apt-get install curl git fzf ripgrep

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp vim/* $HOME/.vim/
