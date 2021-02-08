" coc short cuts
if g:load_coc_nvim
    autocmd BufWritePre *.go execute "normal \<Plug>(coc-format)"
endif

