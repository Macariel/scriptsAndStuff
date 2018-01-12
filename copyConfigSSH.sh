#!/usr/bin/env zsh
tar -czf config.tar.gz -C $HOME .vimrc .zshrc .tmux.conf .oh-my-zsh/ .gitconfig
scp config.tar.gz $1:~
ssh $1 'tar -xzvf config.tar.gz; rm ~/config.tar.gz'
rm config.tar.gz
