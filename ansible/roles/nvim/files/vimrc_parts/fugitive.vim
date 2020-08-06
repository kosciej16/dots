nnoremap <leader>gw :Gwrite!<cr>
nnoremap <leader>gr :Gread<space>
nnoremap <leader>ge :Gedit<space>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gff :Gdiff<cr>
nnoremap <leader>gfm :Gdiff origin/master
nnoremap <leader>ga :Gcommit --amend --no-edit
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gu :Git add -u<cr>
nnoremap <leader>gq :Git add -u <bar> :Gcommit --amend --no-edit <bar> :Git push -f<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>go :.Gbrowse<cr>
vnoremap <leader>go :Gbrowse<cr>

autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
autocmd BufReadPost fugitive://* set bufhidden=delete

autocmd FilterWritePre * if &diff | setlocal wrap< | endif

" gv.vim
nnoremap <leader>gl :GV!<cr>

" twiggy.vim
nnoremap <leader>gt :Twiggy<cr>
