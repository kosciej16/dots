" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
" Basic {{{
syntax on
set number
set visualbell
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc

if !isdirectory($HOME."/.nvim/undodir")
    call mkdir($HOME."/.nvim/undodir", "p", 0700)
endif
set undodir=~/.nvim/undodir
set undofile
set noswapfile
set encoding=utf-8
set whichwrap+=<,>,h,l
set lazyredraw
set foldcolumn=0
set scrolloff=3
set matchpairs+=<:>
set hidden
set smartindent
set nrformats=
set tags=~/.nvim/python_tags;/
set synmaxcol=150  " avoid slow rendering for long lines
" set diffopt+=vertical

" set shortmess+=c CHECK IT
nnoremap j gj
nnoremap k gk
map ; :
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
vnoremap <C-c> "+y
vnoremap <C-x> "+d
inoremap <C-v> <C-r>+
vnoremap p "_dP
" }}}
" Formatting {{{
set tabstop=4
set shiftwidth=0
set softtabstop=8
set expandtab
" }}}
" Searching {{{
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set showmatch
set gdefault
" }}}
