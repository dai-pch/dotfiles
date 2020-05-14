" general config

" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"----------------------------------------------------------------------
" system detection 
"----------------------------------------------------------------------
if exists('g:asc_uname')
    let s:uname = g:asc_uname
elseif has('win32') || has('win64') || has('win95') || has('win16')
    let s:uname = 'windows'
elseif has('win32unix')
    let s:uname = 'cygwin'
elseif has('unix')
    let s:uname = substitute(system("uname"), '\s*\n$', '', 'g')
    if !v:shell_error && s:uname == "Linux"
        let s:uname = 'linux'
    elseif v:shell_error == 0 && match(s:uname, 'Darwin') >= 0
        let s:uname = 'darwin'
    else
        let s:uname = 'posix'
    endif
else
    let s:uname = 'posix'
endif

" if have tags
let g:gutentags_modules = []
if executable('ctags')
    let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
endif

" install coc.nvim only if node exists
let g:load_coc_nvim = 0
if executable('node')
    let g:load_coc_nvim = 1
endif

" plugins 
" let g:plug_url_format='git@github.com:%s.git'
call plug#begin('~/.vim/bundle')
" Plug '' 
Plug 'liuchengxu/vim-which-key', {'on': ['WhichKey', 'WhichKey!', 'WhichKeyVisual', 'WhichKeyVisual!']}
Plug 'flazz/vim-colorschemes' 
Plug 'vim-airline/vim-airline'
Plug 'moll/vim-bbye', {'on': ['Bdelete', 'Bwipeout']}
Plug 'scrooloose/nerdtree',  { 'on': 'NERDTreeToggle' }
if len(g:gutentags_modules) > 0
    if s:uname != 'windows'
        Plug 'ludovicchabant/vim-gutentags'
        Plug 'skywind3000/gutentags_plus'
    else
        Plug 'ludovicchabant/vim-gutentags'
        Plug 'skywind3000/gutentags_plus'
    endif
endif

" language server
if g:load_coc_nvim
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'honza/vim-snippets'
endif

" markdown plugin
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
call plug#end()

" configure
set nocompatible
syntax on          " syntax highlight
let g:solarized_termcolors=256
set background=light
colorscheme solarized
" highlight Normal ctermfg=grey ctermbg=black
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

let mapleader=" "

" Plugs config
" which-key
set timeoutlen=500
autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')
let g:which_key_map = {}
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" NERDTree
let NERDTreeShowHidden=1
map <silent> <leader>d :<C-u>NERDTreeToggle<CR>

" gtags
let $GTAGSLABEL = 'native'
let $GTAGSCONF = expand('~/.local/share/gtags/gtags.conf')

" gutentags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 如果使用 universal ctags 需要增加下面一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif
" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1
" discription
let g:which_key_map.c = {
    \ 'name' : '+tags',
    \ 'g'    : 'looking for the difination.',
    \ 's'    : 'looking for the reference.',
    \ 'c'    : 'looking for the callers of this function.',
    \ 'f'    : 'looking for the files.',
    \ 'i'    : 'looking for the files that include current one.',
    \ }

" coc.nvim
let g:vim_path_in_dotfiles = fnamemodify(resolve(expand('<sfile>:p')), ':h')
if g:load_coc_nvim
    exec 'source' g:vim_path_in_dotfiles . '/coc.vim'
endif

" aireline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'


" key map
" reload config
nnoremap <leader>so :source $MYVIMRC<CR>

nnoremap <tab> >>
nnoremap <S-tab> <<
vnoremap <tab> >gv
vnoremap <S-tab> <gv

nnoremap <leader>o mto<Esc>`t
nnoremap <leader>O mtO<Esc>`t

nnoremap <silent> g; g;zz
nnoremap <silent> g, g,zz

" window
nnoremap <leader>w <C-w>
let g:which_key_map.w = {
            \ 'name': '+window',
            \ 'h'   : 'focus on the left window',
            \ 'l'   : 'focus on the right window',
            \ 'k'   : 'focus on the upward window',
            \ 'j'   : 'focus on the downward window',
            \ }

" buffer operation
nmap <leader>bl :<C-u>ls<CR>
nmap <leader>bn :<C-u>bnext<CR>
nmap <leader>bp :<C-u>bprev<CR>
nmap <leader>bg :<C-u>ls<CR>:buffer<Space>
nmap <leader>bd :<C-u>Bdelete<CR>
nmap <leader>bt :<C-u>exe "tab sb" . v:count<CR>
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
" discription
let g:which_key_map.b = {
    \ 'name' : '+buffer',
    \ 'l'    : 'toggle buffer list.',
    \ 'n'    : 'goto next buffer.',
    \ 'p'    : 'goto previous buffer.',
    \ 'g'    : 'goto buffer of given id.',
    \ 'd'    : 'delete current buffer.',
    \ 't'    : 'edit buffer [N] in a new tab.',
    \ }

" tab
nmap <leader>tc :tabnew<CR>
nmap <leader>te :tabedit<Space>
nmap <leader>tn gt
nmap <leader>tp gT
let g:which_key_map.t = {
            \ 'name': '+tab',
            \ 'c': 'create new tab',
            \ 'e': 'open file',
            \ 'n': 'next tab',
            \ 'p': 'previous tab',
            \ }

" jump
nnoremap <leader>jp <C-o>
nnoremap <leader>jn <C-i>
let g:which_key_map.j = {
            \ 'name': '+jump',
            \ 'n': 'next',
            \ 'p': 'previous',
            \ }

" scroll
nnoremap <silent> <S-k> <C-y>
nnoremap <silent> <S-j> <C-e>

" move on buffer
nmap <silent> <S-h> <Space>bp
nmap <silent> <S-l> <Space>bn

