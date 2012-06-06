" vimrc file

" Pathogen setup - must be first
filetype off			"in case earlier config has turned it on
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on

set nocompatible		" use vim features

" for ruby text object
" http://vimcasts.org/blog/2010/12/a-text-object-for-ruby-blocks/
runtime macros/matchit.vim

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
" alternative mapping for reverse character search
" either we use ,, or 
nnoremap ' ,

" Fast esc in insert mode
inoremap jj <Esc>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

" Longer memory of commands
set history=200

" Disable arrow keys in insert mode so we use normal mode by default
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Command T
" change local directory to current file so command-t lists relevant files
map <leader>c :lcd %:p:h
" refresh command-t so it sees new files and deletes
map <leader>ctf :CommandTFlush
" Here we are trying to get the arrow keys to work when using CommandT in TMux
map <Esc>[A <Up>
map <Esc>[B <Down>
map <Esc>[C <Right>
map <Esc>[D <Left>

" Syntax highlighting always please
syntax on

" highlight .hamlc files as haml
" this should be in a haml or coffee plugin, but isn't at the moment
au BufRead,BufNewFile *.hamlc set ft=haml

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
set softtabstop=2
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

" Working with Split Windows see
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"
" open new vertical split and switch to it
nnoremap <leader>w <C-w>v<C-w>l
" abbreviated mappings for navigating splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Keep focused window at certain width
set wmw=12
set winwidth=84

" Colorschemes
set background=light
colorscheme solarized

" Change how brackets are highlighted
" Default vim config makes brackets hard to read so we will use an underline
" instead
hi MatchParen cterm=underline ctermbg=none ctermfg=none

" Spelling
"
if has("spell")
  " toggle spelling use ,s
  imap <Leader>s <C-o>:setlocal spell! spelllang=en_gb<CR>
  nmap <Leader>s :setlocal spell! spelllang=en_gb<CR>
endif


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

" Vimcast 4 - Tidying Whitespace
"
" Function and autocmd to strip trailing whitespace from files when saving

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

autocmd BufWritePre *.rb,*.markdown,*.feature :call <SID>StripTrailingWhitespaces()

" Improve markdown
"
:autocmd FileType markdown setlocal spell spelllang=en_gb
:autocmd FileType markdown setlocal tw=78 ai com=fb:*-
:autocmd FileType markdown setlocal colorcolumn=80

" the following is for cucumber tables but will sort of work with markdown
" tables see https://gist.github.com/287147
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

