if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/bundle')

Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'vifm/vifm.vim'

Plug 'lambdalisue/suda.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'rhysd/clever-f.vim'
Plug 'vimwiki/vimwiki'

Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'sodapopcan/vim-twiggy'
Plug 'mhinz/vim-signify'
Plug 'vim-test/vim-test'
Plug 'tommcdo/vim-fubitive'

Plug 'altercation/vim-colors-solarized'
" Plug 'chrisbra/Colorizer'
" Plug 'davidhalter/jedi-vim'
" Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'


" Plug 'kshenoy/vim-signature'
Plug 'lervag/vimtex'
" Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
" Plug 'mbbill/undotree'
" Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-abolish'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plug 'wellle/targets.vim'
"
Plug 'psliwka/vim-smoothie'
" Plug 'pearofducks/ansible-vim'

Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'

" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'tell-k/vim-autoflake'
" Plug 'mgedmin/python-imports.vim'
Plug 'alfredodeza/pytest.vim'
Plug 'stsewd/isort.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'benmills/vimux'

Plug 'hashivim/vim-terraform'

" Plug 'ludovicchabant/vim-gutentags'

call plug#end()
filetype plugin indent on    " required
