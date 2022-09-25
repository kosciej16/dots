" search for word under cursor that omits tests
nnoremap <leader>rr :Rg -w <c-r><c-w> --glob "!tests"<CR>
" search everywhere
nnoremap <leader>ra :Rg --hidden<SPACE>
nnoremap <leader>re :Rg -w --hidden <c-r><c-w><CR>
" search current directory word under cursor
nnoremap <leader>rd :Rg <c-r><c-w> "%:p:h"<CR>
" search current directory
nnoremap <leader>rt :Rg  "%:p:h"<S-LEFT><LEFT>
" search for filename nnoremap <leader>rf :Rg %:t:r<CR>
" search for word in clipboard
nnoremap <leader>rc :Rg --hidden <c-r>"<CR>
" search that omits tests
nnoremap <leader>ro :Rg --glob "!tests" --hidden<SPACE>
" search for filename
nnoremap <leader>rf :Rg %:t:r<CR>
nnoremap <leader>rv :Rg --hidden  ~/.config/nvim<S-LEFT><LEFT>

nnoremap \ :Rg<SPACE>

let g:rg_highlight=1

autocmd FileType qf setlocal nowrap
