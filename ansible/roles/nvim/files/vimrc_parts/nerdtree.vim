nnoremap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>

" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.config/nvim/NERDTreeBookmarks")

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

" Quit on opening files from the tree
let NERDTreeQuitOnOpen=1

" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1

" Use a single click to fold/unfold directories and a double click to open
" files
let NERDTreeMouseMode=2

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$', '^\.git$', '__pycache__', '\.DS_Store' ]

let g:NERDTreeWinSize=50

augroup nerdtree
    autocmd!
    autocmd FileType nerdtree map <buffer> bj :BookmarkToRoot judge<cr>cd
    autocmd FileType nerdtree map <buffer> bs :BookmarkToRoot spy<cr>cd
    autocmd FileType nerdtree map <buffer> bt :BookmarkToRoot table<cr>cd
    autocmd FileType nerdtree map <buffer> bn :BookmarkToRoot sentinel<cr>cd
    autocmd FileType nerdtree map <buffer> ba :BookmarkToRoot server<cr>cd
    autocmd FileType nerdtree map <buffer> ci :call NERDTreeAddInit()<cr>
augroup END

function! NERDTreeAddInit()
    let curDirNode = g:NERDTreeDirNode.GetSelected()
    let newNodeName = curDirNode.path.str() . "/__init__.py"

    let newPath = g:NERDTreePath.Create(newNodeName)
    let parentNode = b:NERDTree.root.findNode(newPath.getParent())

    let newTreeNode = g:NERDTreeFileNode.New(newPath, b:NERDTree)
    " Emptying g:NERDTreeOldSortOrder forces the sort to
    " recalculate the cached sortKey so nodes sort correctly.
    let g:NERDTreeOldSortOrder = []
    if empty(parentNode)
        call b:NERDTree.root.refresh()
        call b:NERDTree.render()
    elseif parentNode.isOpen || !empty(parentNode.children)
        call parentNode.addChild(newTreeNode, 1)
        call NERDTreeRender()
        call newTreeNode.putCursorHere(1, 0)
    endif
endfunction

