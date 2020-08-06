cp ~/.aliases/misc files/aliases
sed -i '' '/xclip/d' files/aliases
cp ~/.bashrc files/bashrc
mkdir files/bin
cp ~/bin/new_role files/bin/new_role
