" coc short cuts
if g:load_coc_nvim
    nmap <leader>ltf :CocCommand go.test.generate.function<cr>
    nmap <leader>lta :CocCommand go.test.generate.file<cr>
    nmap <leader>ltp :CocCommand go.test.generate.exported<cr>
    let g:which_key_map.l.t = {
        \ 'name' : '+generate test',
        \ 'f'    : 'generate test for current function.',
        \ 'a'    : 'generate test for all function in file.',
        \ 'p'    : 'generate test for all public function in file.',
        \ }

    nmap <leader>laa :CocCommand go.tags.add<space>
    nmap <leader>lar :CocCommand go.tags.remove<space>
    nmap <leader>lac :CocCommand go.tags.clear<cr>
    let g:which_key_map.l.a = {
        \ 'name' : '+tags',
        \ 'a'    : 'add tags.',
        \ 'r'    : 'remove tags.',
        \ 'c'    : 'clear tags.',
        \ }
endif
