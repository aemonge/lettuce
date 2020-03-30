#!/bin/sh
# Keep you old stuff
mkdir ~/.vim_old
mv ~/.vim ~/.vim_old/.
mv ~/.vimrc ~/.vim_old/.

# Get the VIMRC
mkdir ~/.vim
curl -fLo ~/.vimrc https://raw.githubusercontent.com/aemonge/lettuce/master/.vimrc
curl -fLo ~/.vim/_vim https://raw.githubusercontent.com/aemonge/lettuce/master/_vim

# Get languages
mkdir ~/.vim/spell
curl 'http://ftp.vim.org/pub/vim/runtime/spell/es.utf-8.spl' >~/.vim/spell/es.utf-8.spl
curl 'http://ftp.vim.org/pub/vim/runtime/spell/es.utf-8.sug' >~/.vim/spell/es.utf-8.sug
curl 'http://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.spl' >~/.vim/spell/en.utf-8.spl
curl 'http://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.sug' >~/.vim/spell/en.utf-8.sug

# SPQG -> Start, install plugins, quit and greet
vim +PlugInstall +':qa' && echo 'Vim lettuce installed'

# Link my vim executor in case you want to use it :)
ln -s ~/some/path/to/you/libraries/lettuce/_vim ~/.vim/.;
