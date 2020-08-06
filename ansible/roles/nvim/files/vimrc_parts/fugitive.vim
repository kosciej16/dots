nnoremap <leader>gw :Gwrite!<cr>
nnoremap <leader>gr :Gread<space>
nnoremap <leader>gr :Git fetch <bar> :Git reset --hard origin/master
nnoremap <leader>ge :Gedit<space>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gff :Gdiff<cr>
nnoremap <leader>gfm :Gdiff origin/master
nnoremap <leader>ga :Git commit --amend --no-edit
nnoremap <leader>gc :Git commit<cr>
nnoremap <leader>gu :Git add -u<cr>
nnoremap <leader>gq :Git add -u <bar> :Git commit --amend --no-edit <bar> :Git push -f<cr>
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>go :.GBrowse<cr>
vnoremap <leader>go :GBrowse<cr>

autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
autocmd BufReadPost fugitive://* set bufhidden=delete

autocmd FilterWritePre * if &diff | setlocal wrap< | endif

" gv.vim
nnoremap <leader>gl :GV!<cr>
nnoremap <leader>gv :GV<cr>

" twiggy.vim
nnoremap <leader>gt :Twiggy<cr>

autocmd FileType fugitiveblame nmap <buffer> q gq
autocmd FileType fugitive nmap <buffer> q gq
