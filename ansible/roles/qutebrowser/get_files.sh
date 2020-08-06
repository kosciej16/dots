cp ~/.config/qutebrowser/config.py files
for profile in kosciej ; do
    mkdir -p files/$profile/config
    cp ~/.qutebrowser/$profile/config/quickmarks files/$profile/config/quickmarks 
done
