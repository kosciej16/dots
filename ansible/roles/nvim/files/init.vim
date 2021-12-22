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


augroup test
    autocmd!
    au BufWritePre let a=a+1
augroup END

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction
