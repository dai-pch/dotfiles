" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

call coc#add_extension('coc-go', 'coc-rust-analyzer', 'coc-metals') " , 'coc-tsserver')

let g:which_key_map.l = { 'name': '+language-server' }

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <C-z> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references-used)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>lr <Plug>(coc-rename)
let g:which_key_map.l.r = 'rename'

nmap <leader>li :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
let g:which_key_map.l.i = 'organize import'

nmap <leader>lf  <Plug>(coc-format)
vmap <leader>lf  <Plug>(coc-format-current)
let g:which_key_map.l.x = 'format'

" Apply AutoFix to problem on the current line.
nmap <leader>lx  <Plug>(coc-fix-current)
let g:which_key_map.l.x = 'fix'

nmap <leader>la <Plug>(coc-codeaction-line)
let g:which_key_map.l.a = 'code-action'

nmap <leader>lv <Plug>(coc-range-select)
let g:which_key_map.l.v = 'range-select'

nmap <leader>lb <Plug>(coc-range-select-backward)
let g:which_key_map.l.b = 'range-select-backward'

nmap <leader>lg  :CocCommand go.impl.cursor<cr>
let g:which_key_map.l.g = 'generate interface'

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" coclist key maps
" show all coclist sources
nnoremap <silent> <leader>fl  :<C-u>CocList<cr>
" Show all diagnostics.
nnoremap <silent> <leader>fa  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <leader>fe  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <leader>fc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <leader>fo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <leader>fs  :<C-u>CocList -I symbols<cr>
" Search workspace files.
nnoremap <silent> <leader>ff  :<C-u>CocList files<cr>
" Search using grep.
nnoremap <silent> <leader>fg  :<C-u>CocList grep<cr>
" Do default action for next item.
" nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <leader>fr  :<C-u>CocListResume<CR>
let g:which_key_map.f = {
    \ 'name' : '+CocList',
    \ 'l'    : 'list all sources.',
    \ 'a'    : 'list diagnostics.',
    \ 'e'    : 'list extensions.',
    \ 'c'    : 'list commands.',
    \ 'o'    : 'list symbols of current document.',
    \ 's'    : 'list all symbols.',
    \ 'f'    : 'list files.',
    \ 'r'    : 'resume last list.',
    \ 'g'    : 'list using grep',
    \ }


" coc-settings
" let g:vim_path_in_dotfiles = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let g:coc_config_home = g:vim_path_in_dotfiles
call coc#config('snippets.ultisnips.directories', [
            \ "UltiSnips",
            \ g:vim_path_in_dotfiles . 'snippets'
            \ ])

let g:coc_global_extensions = ['coc-lists', 'coc-json', 'coc-snippets']

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

