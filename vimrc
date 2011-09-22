" vimrc file

" Pathogen setup - must be first
call pathogen#infect()
call pathogen#helptags()

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" leader
let mapleader = ","
let g:mapleader = ","

" Fast editing of the .vimrc
map <leader>e :e! ~/vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/vimrc

