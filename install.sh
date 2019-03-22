mkdir ~/.vim_old
mv ~/.vim  ~/.vim_old/.
mv ~/.vimrc ~/.vim_old/.
mkdir  ~/.vim
git clone git@github.com:aemonge/lettuce.git ~/.vim/lettuce
ln -s ~/.vim/lettuce/.vimrc ~/.
