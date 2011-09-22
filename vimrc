" vimrc file

" Pathogen setup - must be first
filetype off			"in case earlier config has turned it on
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on

set nocompatible		" use vim features

" This configures F2 as a toggle to turn indenting on and off
" Pasting into vim from other applications with indenting on
" is horrible for large blocks of code, so we use this toggle
" to alleviate this problem
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" leader
let mapleader = ","
let g:mapleader = ","

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

" Disable arrow keys in insert mode so we use normal mode by default
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Syntax highlighting always please
syntax on

" No sound on errors
set noeb vb t_vb=
