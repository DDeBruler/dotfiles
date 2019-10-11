" Setup and run vundler on intitial load
set shell=/bin/bash
set nocompatible                                              " be iMproved, required
filetype off                                                  " required for Vundle, switch back later on
set rtp+=~/.vim/bundle/Vundle.vim                             " include Vundle in the runtime path
call vundle#begin()
" List out actual desired plugins
Plugin 'posva/vim-vue'                                        " syntax highlighting for Vue components
Plugin 'kchmck/vim-coffee-script'                             " syntax highlighting for Coffeescript
Plugin 'slim-template/vim-slim.git'                           " syntax highlighting for Slim templates
Plugin 'leafgarland/typescript-vim'                           " syntax highlighting for Typescript
Plugin 'scrooloose/nerdtree'                                  " file system explorer
Plugin 'Xuyuanp/nerdtree-git-plugin'                          "   with git flags plugin
Plugin 'tpope/vim-fugitive'                                   " git command hooks (Ggrep, Gblame, etc)
Plugin 'octref/rootignore'                                    " respect .gitignore when searching
Plugin 'ctrlpvim/ctrlp.vim'                                   " fuzzy file search
Plugin 'haya14busa/incsearch.vim'                             " incremental text search
Plugin 'haya14busa/incsearch-fuzzy.vim'                       "   with fuzzy matching support
" Finish with Vundle handling
call vundle#end()

"
" User/Personal preferences
"
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab   " tab key yields two spaces
set backspace=indent,eol,start                                " backspace can cross lines, indent, and insert-mode start
set nowrap                                                    " do not wrap lines at screen width
set number numberwidth=5                                      " show line numbers
set ruler                                                     " show row,column of current cursor position
set textwidth=0                                               " do not split long lines by default
au BufNewFile,BufRead *.rb set textwidth=100 colorcolumn=+1   " show where 100-character mark hits and split lines on edit
au BufNewFile,BufRead *.slim set textwidth=0 wrapmargin=0     " no line wrapping on slim templates
set nobackup directory=~/.vim/swapfiles//                     " keep swap files out of the working directory
set autowrite                                                 " Automatically :write before running commands
syntax on                                                     " enable syntax highlighting
filetype plugin indent on                                     " detect filetype, enable plugins and indentation by filetype
autocmd FileType vue syntax sync fromstart                    " force full filetype sync for vue components
let g:vue_disable_pre_processors=1                            " avoid heavy preprocessor checks on mixed-language vue components
let g:CommandTTraverseSCM = 'pwd'                             " let RootIgnore affect command-t

" keyboard shortcuts
let mapleader = " "                                           " space bar to start combos
nnoremap <leader>c maggVG"*y`a                                " copy entire file to OS buffer
nnoremap <leader>t :CtrlP                                     " launch fuzzy file search
map <C-n> :NERDTreeToggle<CR>                                 " toggle file explorer pane with ctrl+N
" because I can't pick my pinky up quickly
nnoremap :Q :q
nnoremap :W :w
" because I want to stay in Visual Line mode when I indent
vnoremap > >gv
vnoremap < <gv

" Split pane behavior/navigation
nnoremap <C-J> <C-W><C-J>   " ctrl+J to move down
nnoremap <C-K> <C-W><C-K>   " ctrl+K to move up
nnoremap <C-L> <C-W><C-L>   " ctrl+L to move right
nnoremap <C-H> <C-W><C-H>   " ctrl+H to move left
set splitbelow              " open new horizontal split below the current pane
set splitright              " open new vertical split to the right of the current pane

" incremental text search setup
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map z/ <Plug>(incsearch-fuzzyspell-/)
map z? <Plug>(incsearch-fuzzyspell-?)
map zg/ <Plug>(incsearch-fuzzyspell-stay)
set hlsearch                                " highlight matches
let g:incsearch#auto_nohlsearch = 1         " turn off highlighting after search-related motions
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" Cleanup files on write
augroup file_cleanup
  autocmd!
  " Highlight trailing whitespace
  highlight link ExtraWhitespace Error
  autocmd BufNewFile,BufRead,InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/ " except current line

  function! <SID>StripTrailingWhitespaces()
      let l = line(".")
      let c = col(".")
      %s/\s\+$//e
      call cursor(l, c)
  endfunction
  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
augroup END

" Ensure that arrow keys don't get escaped
nmap <esc>OA <Up>
nmap <esc>OB <Down>
nmap <esc>OC <Right>
nmap <esc>OD <Left>

" highlight current line so I can find my cursor
" set cursorline
" hi cursorline ctermbg=DarkGrey ctermfg=LightGrey cterm=none
