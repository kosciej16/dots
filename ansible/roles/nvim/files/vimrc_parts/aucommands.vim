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

augroup ssh
    autocmd!
    au BufRead,BufNewFile */.ssh/config.d/* set ft=sshconfig
augroup END

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
