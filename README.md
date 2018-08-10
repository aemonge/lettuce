# Lettuce: (neo) Vim Distribution

This is a distribution of plug-ins and mappings for Neo-Vim, Vim, Gvim and MacVim.  It is designed to provide minimal working environment using the most popular plug-ins and the most common mappings.  The distribution is completely custom by overwriting the main configuration file. It differs from other distribution which hide configurations, I kept all together to easy customization of the distribution.

## Pre-requisites

The distribution is designed to work with Vim >= 8.0 or Neo vim.

The distribution also requires `ack`, `ctags`, `git`, and `ag` the silver search


## Installation

To install Lettuce, please install vim plugin manager [vundle](https://github.com/VundleVim/Vundle.vim) and move the file to the correct path:

  *vim* ~/.vimrc
  *neo vim* ~/.local/share/nvim/init.vim


# Intro to VIM

Play this game [vim-adventures](https://vim-adventures.com/) and here are some tips in case you've never used VIM before:

## Tutorials

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

## Modes

* VIM has three modes:
  * insert mode- stuff you type is added to the buffer
  * normal mode- keys you hit are interpreted as commands
  * visual mode- allows you to select blocks of text
* To enter insert mode, hit `i`
* To exit insert mode, hit `<ESC>`
* To enter visual mode, hit `v`
* To exit visual mode, hit `<ESC>`

# License

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
