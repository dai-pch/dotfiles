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
nmap <silent> <leader>h <C-w>h
nmap <silent> <leader>j <C-w>j
nmap <silent> <leader>k <C-w>k
nmap <silent> <leader>l <C-w>l
let g:which_key_map.w = {
            \ 'name': '+window',
            \ }
let g:which_key_map = {
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
" nnoremap <leader>jp <C-o>
" nnoremap <leader>jn <C-i>
" let g:which_key_map.j = {
"             \ 'name': '+jump',
"             \ 'n': 'next',
"             \ 'p': 'previous',
"             \ }

" scroll
nnoremap <silent> <S-k> 7k
nnoremap <silent> <S-j> 7j
nnoremap <silent> <S-h> 7h
nnoremap <silent> <S-l> 7l
vnoremap <silent> <S-k> 7k
vnoremap <silent> <S-j> 7j

" move on buffer
nmap <silent> <C-h> <Space>bp
nmap <silent> <C-l> <Space>bn

" copy to buffer
vmap <silent> <leader>y :w! ~/.vimbuffer<CR>
nmap <silent> <leader>yy :.w! ~/.vimbuffer<CR>
" " paste from buffer
map <silent> <leader>p :r ~/.vimbuffer<CR>
" paste for replace
map <silent> <leader>r mtciw<C-r>0<Esc>`t

" align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" word case convert
"
"let g:which_key_map.c = {
"            \ 'name': '+case convert',
"            \ 'rs': 'snake_case',
"            \ 'rm': 'MixedCase',
"            \ 'rc': 'camelCase',
"            \ 'ru': 'UPPER_CASE',
"            \ 'r-': 'dash-case',
"            \ 'r.': 'dot.case',
"            \ 'r<space>': 'space case',
"            \ 'rt': 'Title Case',
"            \ }

" quick fix
" nnoremap <leader> :cclose<CR>
