let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \}

let g:ale_python_flake8_executable = "~/.local/bin/flake8 --max-line-length=100"
let g:ale_python_black_executable = "~/.local/bin/black -l 100"
let g:ale_fixers = {
      \    'python': ['black', 'isort', 'autopep8'],
      \}

nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 1
