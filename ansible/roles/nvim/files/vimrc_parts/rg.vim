" search for word under cursor
nnoremap <leader>rr :Rg <CR>
" search for filename
nnoremap <leader>rf :Rg %:t:r<CR>
" search for word in clipboard
nnoremap <leader>rw :Rg <c-r>"<CR>
" search that omits tests
nnoremap <leader>rc :Rg --glob "!tests"<SPACE>

nnoremap \ :Rg<SPACE>

let g:rg_highlight=1

autocmd FileType qf setlocal nowrap
