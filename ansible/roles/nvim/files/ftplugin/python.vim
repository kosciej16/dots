noremap <leader>pr :!python3 %<CR>
noremap <leader>pt :!pytest %<CR>
noremap <leader>pm mt?def<CR>O@pytest.mark.mojmarker1<ESC>'t
" noremap <leader>pt :!clear && python -m pytest "mojmarker1"<CR>

" isort {{{
let g:vim_isort_python_version = 'python3'
nnoremap <leader>po :!isort -w 99 %<cr>
" }}}
" auto import {{{
map <leader>pi    mz:ImportName<CR>'z
" }}}
"
