#!/bin/bash 
cp -r ~/.config/nvim/{vimrc_parts,colors,ftplugin,UltiSnips,init.vim} files
tar czf files/vimwiki.tar.gz  -C ~/.config/nvim vimwiki
ansible-vault encrypt files/vimwiki.tar.gz --vault-password-file <(echo `pass ansible`)
