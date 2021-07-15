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
Plug 'tpope/vim-abolish'
Plug 'moll/vim-bbye', {'on': ['Bdelete', 'Bwipeout']}
Plug 'scrooloose/nerdtree',  { 'on': 'NERDTreeToggle' }
Plug 'https://tpope.io/vim/fugitive.git'
Plug 'solarnz/thrift.vim', {'for': ['thrift']}
" Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
" language server
if g:load_coc_nvim
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'honza/vim-snippets'
endif

if len(g:gutentags_modules) > 0
    if s:uname != 'windows'
        Plug 'ludovicchabant/vim-gutentags'
        Plug 'skywind3000/gutentags_plus'
    else
        Plug 'ludovicchabant/vim-gutentags'
        Plug 'skywind3000/gutentags_plus'
    endif
endif

" Debug
Plug 'puremourning/vimspector'

" markdown plugin
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
call plug#end()

" configure
set nocompatible
syntax on          " syntax highlight
let g:solarized_termcolors=256
set background=dark
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
if executable('pygmentize')
    let $GTAGSLABEL = 'native-pygments'
endif
let $GTAGSCONF = expand('~/.local/share/gtags/gtags.conf')

" gutentags
let g:gutentags_define_advanced_commands = 1
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
    \ 'g'    : 'looking for the defination.',
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
if len(g:gutentags_modules) > 0
    let g:airline#extensions#gutentags#enabled = 1
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" short cuts
exec 'source' g:vim_path_in_dotfiles . '/short-cut.vim'

" languages
exec 'source' g:vim_path_in_dotfiles . '/language-common.vim'
exec 'source' g:vim_path_in_dotfiles . '/golang.vim'

" packadd! vimspector
let g:vimspector_enable_mappings = 'HUMAN'
nmap <silent> <leader>dl :call vimspector#Launch()<CR>
nmap <silent> <leader>de :VimspectorReset<CR>
