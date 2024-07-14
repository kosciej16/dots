#!/bin/bash 
cp -r ~/.config/nvim/{ftplugin,init.lua,lua} files
tar czf files/vimwiki.tar.gz  -C ~/.config/nvim vimwiki
# ansible-vault encrypt files/vimwiki.tar.gz --vault-password-file <(echo `pass ansible`)
