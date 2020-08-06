" Color scheme {{{
set background=dark
colorscheme Tomorrow-Night
"
" }}}
" buffers {{{
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>q :call OpenLast()<CR>

function! OpenLast()
  if bufloaded(bufnr('#'))
    execute "normal! :b# \<BAR> bd #\<CR>"
  else
    execute "normal! :bnext \<BAR> bd #\<CR>"
  endif
endfunction

nmap <leader>bl :ls<CR>
" }}}
" other stuff {{{

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
" Switch CWD to the directory of the open buffer
noremap <leader>cd :cd %:p:h<CR>:pwd<CR>
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>
nnoremap <leader>w <C-w>v<C-w>l
cnoremap w!! w suda://%<CR>
" open and close quickfix window
nnoremap <C-q> :call <SID>QuickfixToggle()<cr>

function! s:QuickfixToggle()
    let g:quickfix_is_open = 0
    for winnr in range(1, winnr('$'))
        if getwinvar(winnr, '&syntax') == 'qf'
            let g:quickfix_is_open = 1
        endif
    endfor
    if g:quickfix_is_open
        cclose
    else
        copen
    endif
endfunction

noremap <leader>pj :%!python -m json.tool<CR>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
inoremap <C-k> <C-p>
inoremap <C-j> <C-n>

cnoremap w!! w suda://%<CR>

" }}}
