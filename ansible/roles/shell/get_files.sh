cp ~/.aliases/misc files/aliases
cp ~/.bashrc files/bashrc
cp ~/.zshrc files/zshrc
sed -i "/starfish/d" files/zshrc
mkdir -p files/bin
cp ~/bin/new_role files/bin/new_role
