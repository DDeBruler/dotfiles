" Setup and run vundler on intitial load
set shell=/bin/bash
set nocompatible                                              " be iMproved, required
filetype off                                                  " required for Vundle, switch back later on
set rtp+=~/.vim/bundle/Vundle.vim                             " include Vundle in the runtime path
call vundle#begin()
" List out actual desired plugins
Plugin 'leafgarland/typescript-vim'                           " syntax highlighting for Typescript
Plugin 'scrooloose/nerdtree'                                  " file system explorer
Plugin 'Xuyuanp/nerdtree-git-plugin'                          "   with git flags plugin
Plugin 'tpope/vim-fugitive'                                   " git command hooks (Ggrep, Gblame, etc)
Plugin 'octref/rootignore'                                    " respect .gitignore when searching
Plugin 'ctrlpvim/ctrlp.vim'                                   " fuzzy file search
Plugin 'haya14busa/incsearch.vim'                             " incremental text search
Plugin 'haya14busa/incsearch-fuzzy.vim'                       "   with fuzzy matching support
Plugin 'preservim/nerdcommenter'                              " smart commenting
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
let g:ctrlp_max_files = 0                                     " no limit on number of files to search
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']  " use git to list files for search
setlocal nomodeline                                           " don't accidentally set a mode line based on janky file contents

" keyboard shortcuts
let mapleader = " "                                           " space bar to start combos
map <C-n> :NERDTreeToggle<CR>                                 " toggle file explorer pane with ctrl+N
let g:ctrlp_map = '<leader>t'                                 " launch fuzzy file search

augroup lazy_keystrokes
  autocmd!

  " because I can't pick my pinky up quickly
  nnoremap :Q :q
  nnoremap :W :w

  " because I want to stay in Visual Line mode when I indent
  vnoremap > >gv
  vnoremap < <gv

  " Ensure that arrow keys don't get escaped
  nmap <esc>OA <Up>
  nmap <esc>OB <Down>
  nmap <esc>OC <Right>
  nmap <esc>OD <Left>
augroup END

augroup copy_paste_tools
  autocmd!

  " Copy the whole file to OS Buffer
  nnoremap <leader>c maggVG"+y`a

  " Copy what's under visual to OS Buffer
  vnoremap <leader>c "+y
augroup END

" Split pane behavior/navigation
augroup split_panes
  autocmd!

  nnoremap <C-J> <C-W><C-J>   " ctrl+J to move down
  nnoremap <C-K> <C-W><C-K>   " ctrl+K to move up
  nnoremap <C-L> <C-W><C-L>   " ctrl+L to move right
  nnoremap <C-H> <C-W><C-H>   " ctrl+H to move left
  set splitbelow              " open new horizontal split below the current pane
  set splitright              " open new vertical split to the right of the current pane
augroup END

augroup incremental_search_setup
  autocmd!

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
augroup END

augroup smart_commenting_setup
  autocmd!

  let g:NERDCreateDefaultMappings = 1   " Create default mappings by file type
  let g:NERDSpaceDelims = 1             " Add spaces after comment delimiters by default
augroup END

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
