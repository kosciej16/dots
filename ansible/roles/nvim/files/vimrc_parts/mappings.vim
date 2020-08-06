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
" Easy navigation {{{
" Windows
noremap <C-H> <C-W>h
noremap <C-K> <C-W>k
noremap <C-J> <C-W>j
noremap <C-L> <C-W>l
" Insert
inoremap jk <ESC>
inoremap <C-e> <Esc>A
inoremap <C-a> <Esc>I
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
nnoremap ' `
nnoremap ` '
nnoremap Y y$

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Reselect text that was just pasted with ,v
nnoremap gv `[V`]
nnoremap , za

" Copy file to buffer
noremap <leader>ff :let @+ = expand("%:p")<CR>
noremap <leader>fn :let @+ = expand("%:t")<CR>
noremap <leader>fd :let @+ = expand("%:h")<CR>

nnoremap <C-n> :set relativenumber!<CR>
" Pull word under cursor into LHS of a substitute
nnoremap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" nmap <C-l> :redraw!<CR>
" }}}
" other stuff {{{
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
" Switch CWD to the directory of the open buffer
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

function! VisualSelection(direction, extra_filter) range

    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

nnoremap <leader>w <C-w>v<C-w>l

noremap <leader>pj :%!python -m json.tool<CR>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
inoremap <C-k> <C-p>
inoremap <C-j> <C-n>
" Clears the search register
nnoremap <silent> <leader>/ :nohlsearch<CR>

" noremap <leader>dl dd<c-w><c-l>P<c-w><c-h>
" noremap <leader>dh dd<c-w><c-h>P<c-w><c-l>
tnoremap <Esc> <C-\><C-n>
" }}}
" {{{ Open files
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>es :so $MYVIMRC<CR>
nnoremap <silent> <leader>et :e /tmp/som.py<CR>
nnoremap <silent> <leader>ei :e ~/.config/nvim/bundle/python-imports.vim/myimports.cfg<CR>
" }}}
