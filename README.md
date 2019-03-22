# Lettuce: Vim Distribution (8.1)

This is a distribution of plug-ins and mappings for Vim, Gvim and MacVim.  It is designed to provide minimal working environment using the most popular plug-ins and the most common mappings (meant for US keyboard).

I've done a yearly selection of the most useful and fast plugins, keeping vim as fast as you're used to but even more powerful. This distribution is meant for you to fork and modify it freely. I could have packaged the distribution to keep the _vimrc_ file cleaner and more readable, but it would hide the mappings (and dark magics) that I do for you. So having the distribution been all written in the _vimrc_ file provides a clear knowledge on which plugins I use, which mappings and settings are being set and even you can comment them or modify their options easily.

#### I trust you !
> If you really really trust me, simply execute this `curl` to install this distribution, and remember to manually install the **pre-requisites**.

`culr http://magic`

## Pre-requisites

The distribution is designed to work with Vim >= 8.1, taking advantage of the multi-thread plugin engine and the `:terminal` full integration. It also requires to be compiled with the following flags: `+terminal +clientserver +clipboard +python3`. To verify version and flags run `vim --version`

[Official Vim GitHub](https://github.com/vim/vim/)

It also uses the NPM package manager for node, to have a live syntactical linter [(ALE)](https://github.com/w0rp/ale). And utilizes full 256 terminal colors, with GUI support. So please verify your terminal supports 256 color, which most modern terminal have. You can follow this Wikipedia article that list the [supported terminals](https://en.wikipedia.org/wiki/Comparison_of_terminal_emulators).

> I also recommend setting the colorschme to the dark-vim-hybrid for your terminal following these [instrucctions](https://github.com/w0ng/vim-hybrid)


### Install dependencies --Arch Linux--
> for mac and other distributions please replace the package manager accordingly, ie `brew install node`

* `pacman -S node`. [nodejs](https://nodejs.org/)
* `pacman -S git`. If you're in github, you probably have git installed ;)
* `pacman -S ctags`. [ctags](https://github.com/universal-ctags/ctags)
* `pacman -S the_silver_searcher`. [the_silver_searcher](https://github.com/ggreer/the_silver_searcher)


#### Mac OS Caveats

Compilation of Vim8.1 with the `+clientserver` requires *XQuartz*, for a more details in why is this required please [read this post](http://www.markcampbell.me/2016/04/12/setting-up-yank-to-clipboard-on-a-mac-with-vim.html).

_**tl;dr**_

* `brew install xquartz`
* `brew install vim --with-client-server`


## Installation

To manually install lettuce, simple copy and paste my __.vimrc__ file into your home __~/.vimrc__. Or if you want to keep up to date with me, without forking me (recommend) create a symbolic link such as:

`cd ~/some/path/to/you/libraries;`
`git clone git@github.com:aemonge/lettuce.git;`
`ln -s ~/some/path/to/you/libraries/lettuce/.vimrc ~/.;`

Then start vim, ignoring all errors; things should start installing for you and the second time you open vim there should be no errors. The magic happens thanks to the wonderfull plugin manager [vim-plug](https://github.com/junegunn/vim-plug).

### Kill -9 tmux, screen, terminator, multiplexor !
> I've written a tiny script to make vim act as any multiplexor. Providing you with the same context everywhere, because *it's all text!*

__**~/.bashrc** or **~/.zshrc**__
```
# My own version of tmux
  if [ $VIM_TERMINAL ]; then
    # First change directory to PWD, then open files. Giving a IDE impression
    alias vim="vim --servername $VIM_TERMINAL_PARENT_ID --remote-send \"<C-\><C-n>:cd $(pwd)<cr>\" --remote-tab"
  fi
  if [ -z $VIM_TERMINAL ]; then
    export VIM_TERMINAL_PARENT_ID="$$-VMUX";
    # the exit below is to close the terminal when vmux is done.
    vim +':terminal ++curwin' --servername $VIM_TERMINAL_PARENT_ID && exit
  fi
```

Test it out by opening your terminal, and then going from insert-mode (default landing mode) back to normal-mode with <C-K>, <C-J>. Then call my `:terminal` mapping which is <Leader>x `,x` and there you go! You don't need any other multiplexor

## Uninstall

To clear your vim from plugins and mapping simple remove the __vim__ dir and my __vimrc__ file.
`rm -rf ~/.vimrc ~/.vim`

## Intro to VIM

Play this game [vim-adventures](https://vim-adventures.com/) and here are some tips in case you've never used VIM before:

### Tutorials

* Type `vimtutor` into a shell to go through a brief interactive
  tutorial inside VIM.
* Watch this presentation at [VIM: Walking Without Crutches](https://vimeo.com/16458939) or read the [slides on Speaker Deck](https://speakerdeck.com/nelstrom/vim-precision-editing-at-the-speed-of-thought).
* Watch the screencasts at [vimcasts.org](http://vimcasts.org/)
* Watch Derek Wyatt's energetic tutorial videos at [his site](http://derekwyatt.org/vim/tutorials/)
* Read wycats' perspective on learning Vim at
  [Everyone who tried to convince me to use vim was wrong](http://yehudakatz.com/2010/07/29/everyone-who-tried-to-convince-me-to-use-vim-was-wrong/)
* Read this and other answers to a question about vim at StackOverflow:
  [Your problem with Vim is that you don't grok vi](http://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#1220118)
* Read the [Getting Started with Vim](http://www.sitepoint.com/getting-started-vim/) tutorial on SitePoint
* Read the [Effective Rails Development with Vim](http://www.sitepoint.com/effective-rails-development-vim/) tutorial on SitePoint

### Modes

* VIM has three modes:
  * insert mode- stuff you type is added to the buffer
  * normal mode- keys you hit are interpreted as commands
  * visual mode- allows you to select blocks of text
* To enter insert mode, hit `i`
* To exit insert mode, hit `<ESC>`
* To enter visual mode, hit `v`
* To exit visual mode, hit `<ESC>`



## Special Thanks
> to my favorite vim plugin developers and enthusiast:

* [junegunn](https://github.com/junegunn*)
* [tpope](https://github.com/tpope)
* [Shougo](https://github.com/Shougo)

## License

### This code is free to use under the terms of the MIT license.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
