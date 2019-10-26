" general config

" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins 
" let g:plug_url_format='git@github.com:%s.git'
call plug#begin('~/.vim/bundle')
" Plug '' 
Plug 'flazz/vim-colorschemes' 
Plug 'scrooloose/nerdtree',  { 'on': 'NERDTreeToggle' }

" markdown plugin
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
call plug#end()

" configure
set nocompatible
syntax on          " syntax highlight
set background=dark
colorscheme solarized
highlight Normal ctermfg=grey ctermbg=black
set nu             " show row number
set showcmd        " show input in normal mode
set scrolloff=5    " distance between cursor and bottom when scroll down 

set autoread

set ignorecase
set smartcase

set whichwrap+=<,>,h,l     " allow backspace and cursor keys to cross line boundaries
set nohlsearch
set incsearch
set gdefault       " search/replace gloabl by default

" set textwidth=80
set wrap

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set cindent

set backspace=indent,eol,start

" key map
let mapleader=" "
" reload config
cnoremap so source $MYVIMRC

nmap <tab> >>
nmap <S-tab> <<
vmap <tab> >gv
vmap <S-tab> <gv

nnoremap <leader>o mto<Esc>`t
nnoremap <leader>O mtO<Esc>`t

nnoremap <silent> g; g;zz
nnoremap <silent> g, g,zz

" window
nmap <leader>w <C-w>
" tab
nmap <leader>tc :tabnew<CR>
nmap <leader>te :tabedit
nmap <leader>tn gt
nmap <leader>tp gT

" Plugs config
" NERDTree
let NERDTreeShowHidden=1
map <leader>d :NERDTreeToggle<CR>

