" Color scheme {{{
set background=dark
colorscheme Tomorrow-Night
"
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


function! Red(cmd, rng, start, end)
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~ '^!'
		let cmd = a:cmd =~' %'
			\ ? matchstr(substitute(a:cmd, ' %', ' ' . shellescape(escape(expand('%:p'), '\')), ''), '^!\zs.*')
			\ : matchstr(a:cmd, '^!\zs.*')
		if a:rng == 0
			let output = systemlist(cmd)
		else
			let joined_lines = join(getline(a:start, a:end), '\n')
			let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
			let output = systemlist(cmd . " <<< $" . cleaned_lines)
		endif
	else
		redir => output
		execute a:cmd
		redir END
		let output = split(output, "\n")
	endif
	vnew
	let w:scratch = 1
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, output)
endfunction

" This command definition includes -bar, so that it is possible to "chain" Vim commands.
" Side effect: double quotes can't be used in external commands
command! -nargs=1 -complete=command -bar -range Red silent call Red(<q-args>, <range>, <line1>, <line2>)

" This command definition doesn't include -bar, so that it is possible to use double quotes in external commands.
" Side effect: Vim commands can't be "chained".
command! -nargs=1 -complete=command -range Red silent call Red(<q-args>, <range>, <line1>, <line2>)
" }}}
