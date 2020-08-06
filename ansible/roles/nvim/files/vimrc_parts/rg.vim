" search for word under cursor that omits tests
nnoremap <leader>rr :Rg -w <c-r><c-w> --glob "!tests"<CR>
nnoremap <leader>ra :Rg --hidden<SPACE>
nnoremap <leader>re :Rg -w --hidden <c-r><c-w><CR>
" search current directory
nnoremap <leader>rd :Rg <c-r><c-w> "%:p:h"<CR>
" search for filename nnoremap <leader>rf :Rg %:t:r<CR>
" search for word in clipboard
nnoremap <leader>rw :Rg --hidden <c-r>"<CR>
" search that omits tests
nnoremap <leader>rc :Rg --glob "!tests" --hidden<SPACE>
" search for filename
nnoremap <leader>rf :Rg %:t<CR>
nnoremap <leader>rv :Rg --hidden  ~/.config/nvim<S-LEFT><LEFT>

nnoremap \ :Rg<SPACE>

let g:rg_highlight=1

autocmd FileType qf setlocal nowrap
