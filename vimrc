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

" Turn backup off, since most stuff is in git anyway...
set nobackup
set nowb
set noswapfile

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
 
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Replace tabs with spaces and use 2 spaces by default
set tabstop=2
set shiftwidth=2
set expandtab

" Line numbers
highlight LineNr ctermbg=DarkGrey 
set numberwidth=3
nmap <leader>n :set number!<CR>
set number

" Status line
set laststatus=2
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)

" refresh command-t
map <leader>ctf :CommandTFlush

" ignore tmp folders in file lists (e.g. command-t)
set wildignore+=tmp/**

" ignore img files
set wildignore+=*.gif,*.jpg,*.png

" ignore images in rails applications
set wildignore+='public/imgages/**'

" autosave buffers
set autowriteall

" Keep more context when scrolling off the end of a buffer
set scrolloff=3

" Keep focused window at certain width
set wmw=12
set winwidth=84

" Colorschemes
set background=dark
colorscheme solarized

" Change how brackets are highlighted
" Default vim config makes brackets hard to read so we will use an underline
" instead
hi MatchParen cterm=underline ctermbg=none ctermfg=none

" Running tests the Gary Bernhardt way
"
function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo
    exec ":!bundle exec rspec " . a:filename
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_spec_file = match(expand("%"), '_spec.rb$') != -1
    if in_spec_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

" Run this file
map <leader>r :call RunTestFile()<cr>
" Run only the example under the cursor
map <leader>R :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>
