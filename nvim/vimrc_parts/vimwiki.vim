" let vimwiki_list = [{'path': '~/.config/nvim/vimwiki/'}]
"
"
let wiki_1 = {}
let wiki_1.path = '~/.config/nvim/vimwiki/personal'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let wiki_2 = {}
let wiki_2.path = '~/.config/nvim/vimwiki/work'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.md'

let g:vimwiki_list = [wiki_1, wiki_2]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let vimwiki_map_prefix = "<leader>v"
