  " " ==> Reminders
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " * Standard Vim protocol for quickfixing is to show you the output of the command then jump to the first result automatically. You can cycle through the results with :cn[ext] and :cp[rev].
  " BUFFERS !!!
  " :b <number> 	Display the buffer with the given number.
  " :b <partial> 	Display the first buffer matching the partial name (or press Tab for name completion).
  " Change vim-surround single quotes for double: It's easiest to explain with examples. Press cs"'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                      Initialization (Vim-plug)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  call plug#begin('~/.vim/plugged')
  Plug 'junegunn/vim-plug'
  " Relaod VimRc when modified
    function! PlugAll()
      :PlugClean<cr>
      :PlugInstall<cr>
      :PlugUpdate<cr>
    endfunction
    autocmd! VimLeavePre .vimrc :source ~/.vimrc | exec PlugAll()

  " For windows set the correct shell environments
  if has('win32')
    let $CHERE_INVOKING=1                                                     " Makes bash open in the working directory
    set shell=cmd.exe
    set shellcmdflag=/c\ powershell.exe\ -NoLogo\ -NoProfile\ -NonInteractive\ -ExecutionPolicy\ Bypass " -Command '$LOCALAPPDATA//nvim/profile.ps1'

    " set shellcmdflag=/c\ PowerShell\ -ExecutionPolicy Bypass\ -NoLogo\ -NoProfile\ -NoExit\ -Command \"Invoke-Expression '. ''%ConEmuDir%\..\profile.ps1'''\"\
    set shellpipe=|
    set shellredir=>
    set shellxquote=\"                                                        " Default value is (, but bash needs "
    set shellslash                                                            " Paths will use / instead of \ endif
  endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                             General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Vim Settings
    let mapleader=','                                                          " Change the mapleader
    set timeoutlen=150                                                         " Time to wait for a command
    " set noautochdir                                                            " Don't change Dir on file open
    set autoread                                                               " Set autoread when a file is changed outside
    set autowrite                                                              " Write on make/shell commands au FileChangedShell * echo Warning: File changed on disk
    set hidden                                                                 " Turn on hidden
    set modeline                                                               " Turn on modeline
    set encoding=utf-8                                                         " Set utf-8 encoding
    set completeopt+=longest                                                   " Optimize auto complete
    set completeopt-=preview                                                   " Optimize auto complete
    set noerrorbells                                                           " No sound on errors
    set novisualbell                                                           " No sound on errors
    set t_vb=                                                                  " No sound on errors
    set cursorcolumn                                                           " Display vertical and horizontal current line
    set cursorline                                                             " Display vertical and horizontal current line
    noremap <C-l><C-l> :syntax sync fromstart<cr>:redraw!<cr>
                                                                               " Since vim looses highlight colors sometimes @NOTE: There's double L
    set spl=en_us,es spell
      map <leader>ts :set spell!<cr>

  " Backups
    set noswapfile                                                             " Don't use a .~ swap file
    set undofile                                                               " Use a directory to save undos
    set history=1000                                                           " Increase the lines of history
    set undolevels=10000                                                       " maximum number of changes that can be undone
    set undoreload=10000                                                       " maximum number lines to save for undo on a buffer reload
    set mousehide                                                              " hide while typing
    " set mouse=a                                                                " Mouse can click over buffers, but just that.
    set exrc                                                                   " Execute .vimrc file under current folders ;)
    set secure                                                                 " Just run .vimrc file that the owner is `whoami`
    if has('unix')
      " set cm=blowfish2                                                         " Set the encription method to the best (vim >= 7.4)
      set undodir=~/.vim/undodir
      set backupdir=~/.vim/backup
      if !isdirectory(expand(&undodir))                                        " Create undo directory if it doesn't exist
        call mkdir(expand(&undodir), 'p')
      endif
      if !isdirectory(expand(&backupdir))                                      " Create backup directory if it doesn't exist
        call mkdir(expand(&backupdir), 'p')
      endif
    endif

  " Extra Mappings
    map <leader>tw :set wrap!<cr>
    set breakindent                                                            " Every wrapped line will continue visually indented

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"           Smart Mappings (aka vim tune, with no Plugs)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Make j and k work the way you expect
    nnoremap j gj
    nnoremap k gk
    vnoremap j gj
    vnoremap k gk

  " Repeat last substitution, including flags, with &.
    nnoremap & :&&<CR>
    xnoremap & :&&<CR>


  " Strip all trailing white-space in the current file
    au BufWritePre * %s/\s\+$//e

  " Modify all the indents
    nnoremap <leader>= gg=G

  " Keep the cursor in place while joining lines
    nnoremap J mzJ`z

  " Select entire buffer
    nnoremap vaa ggvGg_

  " Misc
    " save file when accidentally trying to save in insert mode
    imap :w <Esc>:w
    " Double ;; inserts a single ; at the end
    imap ;; <C-o>A;<Esc>
    " Don't search for words on selection mode
    vmap K k
    " Copying pasting
      " Mac Osx Support
      " imap <C-v> <Esc>:set paste<cr>:r !pbpaste<cr>:set nopaste<cr>
      " Linux support
      imap <C-v> <C-o>"+p
      set clipboard=unnamed
    vmap <C-p> "+p<cr>
    vmap <C-C> "+y
    vmap  "+y
    " a bit faster to get the q: and my own f:
    nmap q; q:
    nmap f; f:

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                          Completions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Settings
    " Line Completion
    imap <C-l> <c-x><C-l>
    " Omni Completion
    imap <C-k> <c-x><c-o>
    "Spelling Completion
      imap <C-h> <c-x>s
      if has('win32')
        imap <C-h> <c-x>s<c-n><c-n><c-p>
      endif
    "File Completion
    imap <C-f> <c-x><c-f>

  " Plugs
    Plug 'Shougo/neocomplete.vim'                                            " Full time complete (alternative for YCM)
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#sources#syntax#min_keyword_length = 4
    let g:neocomplete#enable_auto_select = 1
    let g:neocomplete#auto_complete_delay = 30
    let g:neocomplete#enable_fuzzy_completion = 1
      " <TAB>: completion. and closing with C-K and C-L
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " Start the completion with C-K accept it with C-L
    inoremap <expr><C-K> neocomplete#start_manual_complete()
    inoremap <expr><C-L> neocomplete#smart_close_popup()."\<CR>"
    inoremap <expr><C-L> pumvisible() ? "\<C-y>" : "\<CR>"
    " Close completion pop-up when deleting character
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                         Fold Related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Settings
    set foldlevelstart=0                                                       " Start with all folds closed
    set foldmethod=indent

  " Mappings
    map <leader>fe :set foldenable!<cr>

  " Plugs
    " Mantain fold when editing @original from VIM-Tip
    set foldopen=hor,mark,percent,quickfix,search,tag,undo
    au InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    au InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                            Fancy
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Settings
    set t_Co=256                                                               " Set current terminal to 256 colors
    set title                                                                  " Set title
    set titlestring=%t%(\ %m%)%(\ (%{expand('%:p:h')})%)%(\ %a%)               " Don't show full paths, abbreviate them
    set guitablabel=%m%N:%t[%{tabpagewinnr(v:lnum)}]                           " Don't know this line, sorry.
    set wildmenu                                                               " Show list instead of just completing
    set wildmode=list:longest,full                                             " Use powerful wildmenu
    set shortmess=at                                                           " Avoids hit enter
    set showcmd                                                                " Show cmd
    set whichwrap+=h,l,<,>,[,]                                                 " Backspace and cursor keys wrap to
    set sidescroll=1                                                           " Minimal number of columns to scroll horizontally
    set showmatch                                                              " Show matching brackets/parenthesis
    set matchtime=2                                                            " Decrease the time to blink
    set relativenumber                                                         " Show line numbers relative
    set number!                                                                " Show the current line number ;)
    set formatoptions+=rnlmM                                                   " Optimize format options
    set wrap                                                                   " We like when we don't have hidden info, lets see it all
    set textwidth=120                                                          " Change text width
    set list                                                                   " Show these tabs and spaces and so on
    set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮                           " Change listchars Preaty special characters
    set linebreak                                                              " Wrap long lines at a blank
    set showbreak=↪                                                            " Change wrap line break
    set fillchars=diff:⣿,vert:│                                                " Change fillchars
    set cc=120                                                                 " visible column at 120 so we can knwo our limit

  " Plugs
    Plug 'godlygeek/CSApprox'
    Plug 'w0ng/vim-hybrid'                                                     " Colorscheme hybrid
      silent! function! SetTheme()
        set background=dark
        colorscheme hybrid
        hi clear SpellBad
        hi clear SpellCap
        hi SpellBad     gui=underline cterm=underline
        hi SpellCap     gui=underline cterm=underline
        hi NonText      ctermbg=none
        hi Terminal     ctermbg=none
        hi Normal       ctermbg=none
        hi Folded       ctermbg=none
        hi CursorLine   ctermbg=none
        hi CursorLine   gui=bold      cterm=bold
        hi CursorColumn ctermbg=none
        hi CursorColumn gui=bold      cterm=bold
        hi SignColumn   ctermbg=none
        hi SignColumn   gui=bold      cterm=bold
      endfunction

    if !exists("g:hybrid_use_Xresources")
      let g:hybrid_use_Xresources = 0
    endif

    " Highlight clear
    if exists("syntax_on")
      syntax reset
    endif

    Plug 'vim-airline/vim-airline'
      Plug 'vim-airline/vim-airline-themes'
      Plug 'enricobacis/vim-airline-clock'
      let g:airline_theme = 'hybridline'
      let g:airline_solarized_bg='dark'
      let g:airline_detect_spell=0
      let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
      let g:airline_extensions = ['tabline', 'clock', 'ale']
      " Fugitive
      let g:airline#extensions#fugitiveline#enabled = 1
      " Tab-line
      let g:airline#extensions#tabline#show_tab_nr = 0
      let g:airline#extensions#tabline#tabs_label = ''
      let g:airline#extensions#tabline#buffers_label = ''
      let g:airline#extensions#tabline#show_tabs = 1
      let g:airline#extensions#tabline#show_buffers = 0
      let g:airline#extensions#tabline#buffer_idx_mode = 1
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
      let g:airline#extensions#tabline#show_splits = 0
      " ALE
      let g:airline#extensions#ale#enabled = 1
      let airline#extensions#ale#show_line_numbers = 1
      let airline#extensions#ale#error_symbol = '✗'
      let airline#extensions#ale#warning_symbol = '∆'



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                             IDE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Nerd Tree alike file explorer
    Plug 'scrooloose/nerdtree'                                                 " NERD tree
      map <leader>N :NERDTreeToggle<cr>
      map <leader>n :NERDTreeFind<cr>
      let NERDTreeDirArrows=1
      let NERDTreeQuitOnOpen = 1

  " Plugs
    Plug 'ctrlpvim/ctrlp.vim'                                                  " Fuzzy file opener
      let g:ctrlp_map = '<c-p>'
      let g:ctrlp_cmd = 'CtrlP'
      let g:ctrlp_working_path_mode = 'ra'
      let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/](doc|tmp|node_modules)',
        \ 'file': '\v\.(exe|so|dll)$',
        \ }
      nmap <C-b> :CtrlPBuffer<cr>
    Plug 'tpope/vim-commentary'                                                " Comment stuff out
      noremap <leader>/ :Commentary<cr>
    Plug 'tpope/vim-surround'                                                  " Surround
    Plug 'editorconfig/editorconfig-vim'
      let g:EditorConfig_exclude_patterns = ['scp://.*']
    Plug 'mtth/scratch.vim'                                                    " A simple Scratch window for tooling
      nmap <leader>st :Scratch<cr>
    Plug 'tpope/vim-fugitive'                                                  " Git wrapper

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                    Expected Enhancements
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Settings
    set laststatus=2                                                           " Enables the status line at the bottom of Vim Only when SPLIT

  " Mappings
    " When pasting don't replace the current register.
    xnoremap p pgvy

  " Plugs
    Plug 'chrisbra/sudoedit.vim'                                               " Enable sudo CRUD operations with none sudo vim instance
    Plug 'tpope/vim-repeat'                                                    " Repeat
    Plug 'Raimondi/delimitMate'                                                " Closing of quotes
    Plug 'vim-scripts/BufOnly.vim'                                             " Delete all the buffers except the current/named buffer
    " Plug 'rhysd/vim-grammarous'                                                " vim-grammarous is a powerful grammar checker for Vim. Simply do :GrammarousCheck to see the powerful checking

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                           Motions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Plugs
    Plug 'bkad/CamelCaseMotion'                                                " Camel case motion
      map w <Plug>CamelCaseMotion_w
      map b <Plug>CamelCaseMotion_b
      map e <Plug>CamelCaseMotion_e
      sunmap w
      sunmap b
      sunmap e
      omap iw <Plug>CamelCaseMotion_iw
      xmap iw <Plug>CamelCaseMotion_iw
      omap ib <Plug>CamelCaseMotion_ib
      xmap ib <Plug>CamelCaseMotion_ib
      omap ie <Plug>CamelCaseMotion_ie
      xmap ie <Plug>CamelCaseMotion_ie

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                           Syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Plugs
    Plug 'sheerun/vim-polyglot'                                                " Language Support a TON
      let g:polyglot_disabled = ['graphql']                                      " Due to the following bug: https://github.com/sheerun/vim-polyglot/issues/331
      " Plug 'vim-scripts/Txtfmt-The-Vim-Highlighter'                            " for Rich-text
      Plug 'flniu/confluencewiki.vim'                                          " Support for confluence wiki (also jira descriptions)
      au BufNewFile,BufReadPost *.wiki set filetype=confluencewiki
    Plug 'w0rp/ale', { 'do': 'npm i -g ts-server tslint eslint vimlint prettier jsonlint fixjson eslint-plugin-react eslint-plugin-node eslint-plugin-vue eslint-plugin-standard eslint-plugin-html eslint-plugin-lodash eslint-plugin-es eslint-plugin-filenames eslint-plugin-json eslint-plugin-ember eslint-plugin-import eslint-import-resolver-webpack jsctags stylelint-config-recommended' }              " A version of Syntactic that works a-sync
      map <leader>te :ALEToggle<cr>
      Plug 'Valloric/ListToggle'
        map <script> <silent> <leader>e :call ToggleLocationList()<CR>
        map <leader>ee :ALEDetail<cr><C-W>w
        let g:lt_location_list_toggle_map = '<leader>e'
      let g:ale_sign_error = '✗'
      let g:ale_sign_warning = '∆'
      let g:ale_completion_enabled = 1
      " Disabled tsserver in typescript since my machine is TOO slow.
      let g:ale_linters = {
      \  'typescript': [ 'tslint', 'tsserver' ],
      \  'javascript': [ 'eslint' ],
      \  'jsx': [ 'eslint' ],
      \  'json': [ 'jsonlint' ]
      \}
      let g:ale_fixers = {
      \  'typescript': [ 'tslint', 'prettier' ],
      \  'javascript': [ 'eslint', 'prettier' ],
      \  'jsx': [ 'eslint', 'prettier'  ],
      \  'json': ['fixjson'],
      \  'css': ['prettier'],
      \  'markdown': ['prettier'],
      \  '*': ['prettier']
      \}
      let g:ale_fix_on_save = 0
      let g:ale_lint_on_save = 1
      let g:ale_lint_on_enter=0
      let g:ale_lint_on_filetype_changed=0
      let g:ale_lint_on_insert_leave=0
      let g:ale_lint_on_text_changed=0
    Plug 'ternjs/tern_for_vim', { 'do' : 'npm i' }                             " This is a Vim plugin that provides Tern-based JavaScript editing support.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                   Tab, Splits & Navigation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Settings
    set splitbelow

  " Mappings
    nmap _ :2wincmd -<cr>
    nmap + :3wincmd +<cr>
    nmap = :3wincmd <<cr>
    nmap - :2wincmd ><cr>
    map <C-j> :wincmd w<cr>
    map <C-k> :wincmd W<cr>

  " quick tab move [ tab, and shift tab ]
    nmap <C-l> gt<cr>
    nmap <C-h> gT<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                   Internal Efficiency
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Settings
    set ttyfast                                                               " Faster Terminal, redraws stuff quicker!
    set linespace=0                                                           " No extra spaces between text lines
    set lazyredraw                                                            " Don't update the display while executing macros

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                   Indent and formatting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Settings
    set autoindent                                                             " Preserve current indent on new lines
    set cindent                                                                " set C style indent
    set expandtab                                                              " Convert all tabs typed to spaces
    set tabstop=2                                                              " Indentation levels every four columns
    set softtabstop=2                                                          " Indentation levels every four columns
    set shiftwidth=2                                                           " Indent/outdent by four columns
    set shiftround                                                             " Indent/outdent to nearest tabstop

  " Plugs
    Plug 'godlygeek/tabular'                                                   " Sometimes, it's useful to line up text
      nmap <Leader>a :Tab<CR>
      vmap <Leader>a :Tab<CR>
      nmap <Leader>t :Tabularize /
      vmap <Leader>t :Tabularize /
    function! AutoFormatNFix()
      :Autoformat
      :ALEFix
    endfunction
    Plug 'chiel92/vim-autoformat', { 'do': 'npm install -g js-beautify eslint typescript-formatter' }       " Format all code uses js-beautify for JS
     noremap <leader>= :call AutoFormatNFix()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                        Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Settings
    set ignorecase
    set smartcase                                                              " Case sensitive when uc present
    set hlsearch                                                               " Highlight search terms
    set incsearch                                                              " Find as you type search

  " Mappings
    vmap A $
    vmap I ^
    vmap s :s/
    " double // to search selected text ;)
    vnorem // y/<c-r>"<cr>
    vnorem <C-H> y:<C-f>pI%S/<Esc>A//gic<Esc>hhhi
    " Use ,Space to toggle the highlight search
    nnoremap <Leader><Space> :noh<CR>

  " Plugs
    Plug 'mileszs/ack.vim'                                                     " Search in the whole project (folder)
      nnoremap <Leader>f :Ack!<Space>
      vnoremap <Leader>f y:Ack! <C-r>=fnameescape(@")<CR><CR>
      if executable('ag')
        let g:ackprg = 'ag --vimgrep'
      endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                        Terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  function! TerminalThemeIn()
    set nonumber
    set norelativenumber
    set nospell
    set noshowmode
    set noruler
    set noshowcmd
    set nowrap
    :noh
  endfunction

  function! TerminalThemeOut()
    set number
    set relativenumber
    set spell
    set showmode
    set ruler
    set showcmd
    set wrap
  endfunction

  function! NewTermTab()
    :tabnew<cr>
    :terminal ++curwin
  endfunction

  function! TerminalMapping()
    " To use `ALT+{h,j,k,l}` to navigate windows from any mode:
    tnoremap <ESC><ESC> <C-\><C-n>
    tnoremap <C-j> <C-\><C-N><C-w>j
    tnoremap <C-k> <C-\><C-N><C-w>k
    tnoremap <C-l> <C-\><C-N>gt
    tnoremap <C-h> <C-\><C-N>gT

    " New Terminal in Tab and horizontal split
    noremap <C-t> :call NewTermTab() <cr>
    tnoremap <C-t> <C-\><C-N>:call NewTermTab()<cr>
    nmap <leader>x :terminal<cr>

    " Refresh and clear command to terminal
    tnoremap <C-l><C-l> clear<cr>
    tnoremap <C-l><C-l><C-l> reset<cr>
  endfunction

  function! TerminalIfLastExit()
    if tabpagenr('$') == 1 " We are (currently) not in the last tab
      :qa
    endif
  endfunction

  function! TerminalPlusPlus()
    au TerminalOpen * if &buftype == 'terminal' | call TerminalThemeIn() | endif
    autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | silent! normal i | endif
    au BufEnter * if &buftype != 'terminal' | call TerminalThemeOut() | endif
    au BufLeave * if &buftype == 'terminal' | call TerminalIfLastExit() | endif
    call TerminalMapping()
  endfunction
  exec TerminalPlusPlus()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                     Local Plugs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  function! DebugVar()
    if &ft == 'javascript' || &ft == 'jasmine.javascript' || &ft == 'javascript.jsx' || &ft == 'html' || &ft == 'typescript'
      exe "normal oconsole.log();"
      exe "normal hi': ', "
      exe "normal pg;"
      exe "normal bblp^j"
    elseif &ft == 'php'
      exe "normal ovar_dump();"
      exe "normal hi': ', "
      exe "normal pg;"
      exe "normal bblp^j"
    elseif &ft == 'sql'
      exe "normal oselect ;"
      exe "normal hi': ', "
      exe "normal pg;"
      exe "normal bblp^j"
    else
      echo &ft
      echo "not implemente yet, please do"
    endif
  endfunction
  nmap <leader>v :call DebugVar()<cr>

  " Move Left After Tab Close
  function! MoveToTabOnLeft()
    let current = tabpagenr()
    let last = tabpagenr('$')
    if current != last " We are (currently) not in the last tab
      let tabonleft = current - 1
      exe tabonleft."tabnext"
    endif
  endfunction
  function! IfTabOnlyThenBufOnly()
    if tabpagenr('$') == 1 " We are (currently) not in the last tab
      BOnly
    endif
  endfunction
  augroup tabonleft
      au!
      au TabClosed * call MoveToTabOnLeft()
      au TabClosed * call IfTabOnlyThenBufOnly()
  augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"                    Finizalization
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    Plug 'zef/vim-cycle'
      au VimEnter * call AddCycleGroup(['set', 'get'])
      au VimEnter * call AddCycleGroup(['form', 'to'])
      au VimEnter * call AddCycleGroup(['push', 'pop'])
      au VimEnter * call AddCycleGroup(['mas', 'menos'])
      au VimEnter * call AddCycleGroup(['prev', 'next'])
      au VimEnter * call AddCycleGroup(['start', 'end'])
      au VimEnter * call AddCycleGroup(['light', 'dark'])
      au VimEnter * call AddCycleGroup(['open', 'close'])
      au VimEnter * call AddCycleGroup(['read', 'write'])
      au VimEnter * call AddCycleGroup(['truthy', 'falsy'])
      au VimEnter * call AddCycleGroup(['filter', 'reject'])
      au VimEnter * call AddCycleGroup(['disable', 'enable'])
      au VimEnter * call AddCycleGroup(['disabled', 'enabled'])
      au VimEnter * call AddCycleGroup(['internal', 'external'])
      au VimEnter * call AddCycleGroup(['short', 'normal', 'long'])
      au VimEnter * call AddCycleGroup(['subscribe', 'unsubscribe'])
      au VimEnter * call AddCycleGroup(['header', 'body', 'footer'])
      au VimEnter * call AddCycleGroup(['protected', 'private', 'public'])
      au VimEnter * call AddCycleGroup(['red', 'blue', 'green', 'yellow'])
      au VimEnter * call AddCycleGroup(['tiny', 'small', 'medium', 'big', 'huge'])
      au VimEnter * call AddCycleGroup(['debug', 'info', 'warn', 'error', 'silent'])
      au VimEnter * call AddCycleGroup(['pico', 'nano', 'micro', 'mili', 'kilo', 'mega', 'giga', 'tera', 'peta'])
      au VimEnter * call AddCycleGroup(['sunday', 'monday', 'tuesday', 'wensday', 'thursday', 'friday', 'saturday'])

  " Theme Should be at last I don't know why
      call plug#end()
      exec SetTheme()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"""""""""""""""""""""""""""""""""""""|
"            Discarded Plugs: Written here to remember not to use them
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " Plug 'KeitaNakamura/highlighter.nvim', { 'do': ':UpdateRemotePlugs' }
  " Plug 'Lokaltog/vim-easymotion'                                             " Easy motion
  " Plug 'Quramy/tsuquyomi'                                                      " SUPER SLOWS EVERYTHING Make your Vim a TypeScript IDE
  " Plug 'Quramy/vim-dtsm'                                                       " SUPER SLOWS EVERYTHING provides .d.ts management for dtsm users.
  " Plug 'Quramy/vim-js-pretty-template'                                         " provides syntax highlight for contents in Template Strings.
  " Plug 'Shougo/deoplete.nvim'                                                " Dark powered asynchronous completion framework for neovim/Vim8
  " Plug 'Shougo/neosnippet-snippets'
  " Plug 'Shougo/neosnippet.vim'
  " Plug 'SirVer/ultisnips'
  " Plug 'Valloric/YouCompleteMe', { 'do': './install.py --js-completer' }
  " Plug 'aemonge/nerdcommenter'                                               " NERD commenter
  " Plug 'airblade/vim-gitgutter'                                              " Git diff sign
  " Plug 'altercation/vim-colors-solarized'
  " Plug 'bendavis78/vim-polymer'
  " Plug 'csscomb/vim-csscomb'
  " Plug 'easymotion/vim-easymotion'                                          " EasyMotion provides a much simpler way to use some motions in vim.
  " Plug 'haya14busa/incsearch-easymotion.vim'
  " Plug 'haya14busa/incsearch-fuzzy.vim'
  " Plug 'haya14busa/incsearch.vim'                                            " Improved incremental searching for Vim
  " Plug 'honza/vim-snippets'
  " Plug 'jason0x43/vim-js-indent'                                               " provides function of indent for both JavaScript and TypeScript.
  " Plug 'jaxbot/browserlink.vim'                                              " Connect vim with broswer console and edition
  " Plug 'jeetsukumaran/vim-buffergator'                                       " Vim Plug to list, select and switch between buffers.
  " Plug 'junegunn/limelight.vim'
  " Plug 'kristijanhusak/vim-multiple-cursors'                                 " Multiple cursors
  " Plug 'kylef/apiblueprint.vim'                                            " API Blueprint
  " Plug 'majutsushi/tagbar'                                                   " Tag bar
  " Plug 'mhartington/vim-typings'                                               " SUPER SLOWS EVERYTHING provides .d.ts management for typings users.
  " Plug 'mhinz/vim-startify'                                                  " The fancy start screen
  " Plug 'moll/vim-node'
  " Plug 'othree/eregex.vim'                                                   " Use the Perl/Ruby(/JavaScript) Regex engine.
  " Plug 'othree/javascript-libraries-syntax.vim'                              " The alternative for tern_for_vim. Syntax for JS libs
  " Plug 'polpo/vim-html-js-indent'                                          " This indent Plug restores the inline JavaScript/HTML indenting support which was removed from vim-javascript.
  " Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}
  " Plug 'rhysd/devdocs.vim'                                                     " This is a Vim Plug for devdocs, which is an awesome multiple API documentation service. You can open and search devdocs from Vim.
  " Plug 'roxma/nvim-yarp'
  " Plug 'roxma/vim-hug-neovim-rpc'
  " Plug 'scrooloose/nerdtree'                                                 " NERD tree
  " Plug 'shougo/deol.nvim'                                                    " A powerful shell implementation by vim (for windows)
  " Plug 'sickill/vim-pasta'                                                   " Paste Aligned to context
  " Plug 'simnalamburt/vim-mundo'                                              " See the undo history graphically
  " Plug 'tmhedberg/matchit'                                                   " Match it
  " Plug 'vim-scripts/ReplaceWithRegister'
  " Plug 'vim-scripts/TwitVim'
  " Plug 'vim-scripts/colorsupport.vim'
  " Plug 'vim-scripts/loremipsum'
  " Plug 'zweifisch/pipe2eval'
