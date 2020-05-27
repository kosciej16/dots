kill agent:
gpgconf --kill gpg-agent

run agent:
gpg-connect-agent /bye

public key:
gpg --armor --export user-id > pubkey.asc

private key:
gpg --export-secret-keys --armor user-id > privkey.asc
