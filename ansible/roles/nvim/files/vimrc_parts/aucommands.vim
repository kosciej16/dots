augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted | map <buffer> q :cclose<cr>
augroup END

augroup aliases
    autocmd!
    au BufRead,BufNewFile */.aliases/* set ft=bash
augroup END

augroup tmux
    autocmd!
    au BufRead,BufNewFile */.config/tmux/* set ft=tmux
augroup END
