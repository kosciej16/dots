Qutebrowser

TODO:
- [ ] Pass support as optional step
- [ ] Cleanup
- [ ] Install QT from sources to make ffmpeg codecs working
- [ ] Profiles read from directory instead hardcoded
- [ ] Own server for storing gpupg key
- [ ] Pass url from file/variable
- [ ] gnupg right (700 dir, 600 content)

IDEAS:
- [ ] Install pip/git and more as common role in each playbook
- [ ] Should package install (pass and rofi here) be splitted?


# run application from anywhere
spctl --master-disable

# password policy
pwpolicy getaccountpolicies > som.xml
<change 4 to 1 in password + remove first line>
pwpolicy setaccountpolicies som.xml
