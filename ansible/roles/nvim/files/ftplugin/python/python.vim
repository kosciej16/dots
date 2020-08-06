let g:python3_host_prog = "/home/kosciej/virt/neovim3/bin/python"

noremap <leader>pr :!python3 %<CR>
noremap <leader>pm mt?def<CR>O@pytest.mark.mojmarker1<ESC>'t
noremap <leader>pt :!clear && python -m pytest "mojmarker1"<CR>

" isort {{{
let g:vim_isort_python_version = 'python3'
nnoremap <leader>po :Isort<cr>
" }}}
" auto import {{{
map <leader>pi    mz:ImportName<CR>'z
" }}}
"
