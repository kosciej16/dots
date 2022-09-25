let g:fzf_history_dir = '~/.local/share/fzf-history'

let fzf_vim_files = globpath("~/.config/nvim/vimrc_parts", "*") . "\n"
            \ . globpath("~/.config/nvim/ftplugin/**", "*.vim") . "\n"
            \ . expand("~/.config/nvim/coc-settings.json") . "\n"
            \ . expand("~/.config/nvim/init.vim") . "\n"

map ,v :call fzf#run(fzf#wrap({'source': split(fzf_vim_files)}))<cr>

let fzf_dot_files =  expand("~/.zshrc") . "\n"
            \ . expand("~/.zshenv") . "\n"
            \ . expand("~/.profile") . "\n"
            \ . expand("~/repos/other/new_comp/steps") . "\n"
            \ . expand("~/.gitconfig") . "\n"
            \ . expand("~/.config/khal/config") . "\n"
            \ . expand("~/.config/vdirsyncer/config") . "\n"
            \ . expand("~/.config/qutebrowser/config.py") . "\n"
            \ . expand("~/.mbsyncrc") . "\n"
            \ . expand("~/.msmtprc") . "\n"
            \ . globpath("~/.config/neomutt/", "*") . "\n"
            \ . globpath("~/.config/tmux/", "*") . "\n"
            \ . globpath("~/.config/bspwm//", "*") . "\n"
            \ . globpath("~/.config/sxhkd/", "*") . "\n"
            \ . globpath("~/.aliases/", "*") . "\n"
map ,d :call fzf#run(fzf#wrap({'source': split(fzf_dot_files)}))<cr>

nmap <C-p> :Files<cr>
nmap ,b :Buffers<cr>
nmap <C-,> :Buffers<cr>
nmap <C-[> :Buffers<cr>
nmap ,l :Lines<cr>
nmap ,m :Marks<cr>
nmap ,o :Locate<space>

" map ,v :call fzf#run({'source': map(split(vim_files), 'fnamemodify(v:val, ":t:r")'),
" 
"
"
" function! s:build_quickfix_list(lines)
"   call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
"   copen
"   cc
" endfunction
"
" let g:fzf_action = {
"   \ 'ctrl-q': function('s:build_quickfix_list'),
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-x': 'split',
"   \ 'ctrl-v': 'vsplit' }
