augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted | map <buffer> q :cclose<cr>
augroup END
