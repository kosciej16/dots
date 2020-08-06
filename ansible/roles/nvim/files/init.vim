set nocompatible
filetype off

let mapleader = " "

source ~/.config/nvim/vimrc_parts/plugins.vim

source ~/.config/nvim/vimrc_parts/ale.vim
source ~/.config/nvim/vimrc_parts/airline.vim
source ~/.config/nvim/vimrc_parts/autoflake.vim
source ~/.config/nvim/vimrc_parts/coc.vim
source ~/.config/nvim/vimrc_parts/commentary.vim
source ~/.config/nvim/vimrc_parts/easymotion.vim
source ~/.config/nvim/vimrc_parts/fugitive.vim
source ~/.config/nvim/vimrc_parts/fzf.vim
" source ~/.config/nvim/vimrc_parts/nerdcomment.vim
source ~/.config/nvim/vimrc_parts/nerdtree.vim
source ~/.config/nvim/vimrc_parts/test.vim
source ~/.config/nvim/vimrc_parts/rg.vim
source ~/.config/nvim/vimrc_parts/terraform.vim
source ~/.config/nvim/vimrc_parts/ultisnips.vim
source ~/.config/nvim/vimrc_parts/vimtex.vim
source ~/.config/nvim/vimrc_parts/vimwiki.vim
source ~/.config/nvim/vimrc_parts/vimux.vim
source ~/.config/nvim/vimrc_parts/gutentags.vim

source ~/.config/nvim/vimrc_parts/advanced.vim
source ~/.config/nvim/vimrc_parts/aucommands.vim
source ~/.config/nvim/vimrc_parts/autopaste.vim
source ~/.config/nvim/vimrc_parts/basic.vim
source ~/.config/nvim/vimrc_parts/mappings.vim

let g:python3_host_prog = "$HOME/neovim/bin/python"

function Moja()
    let cont = split(expand("%:p"), '/')[4]
    let suffix = join(split(expand("%"), '/')[1:], '/')
    let to = cont . ':home/revolut/app/src/' . suffix
    execute "!docker cp " . expand("%:p") . " " . to
    return to
endfunction

function Moja2()
    let cont = split(expand("%:p"), '/')[4]
    let suffix = join(split(expand("%:h:h"), '/')[1:], '/')
    let to = cont . ':home/revolut/app/src/' . suffix
    execute "!docker cp " . expand("%:h") . " " . to
    return to
endfunction

function Foo()
    let title = input('Title: ')
    put =title
    center
    let line=getline(line('.'))
    let spaces = matchstr(line, '^\s*\ze\s')
    let prefix = substitute(spaces, ' ', '#', 'g')
    call setline(line('.'), prefix . ' ' . trim(line) . ' ')
    normal 80A#
    normal d80|
endfunction

noremap <leader>x :call Foo()<cr>

command! -nargs=1 MyCommand call s:MyFunc(<f-args>)


map <leader>tg :r new<cr>
map <leader>tc :r code<cr>

" autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1" | redraw!
