function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction

autocmd FileType vim,c,cpp,java,php,ruby,python,go autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

