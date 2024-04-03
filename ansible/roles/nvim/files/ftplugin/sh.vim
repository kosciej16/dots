noremap <buffer><leader>pc :!chmod +x %<CR>
noremap <buffer><leader>pr :let save_dir = getcwd()<CR>:cd %:p:h<CR>:!%:p<CR>:cd <C-R>=save_dir<CR><CR>
