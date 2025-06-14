update_gpg_tty() gpg-connect-agent updatestartuptty /bye &>/dev/null
lsfn() ls

autoload -U add-zsh-hook
add-zsh-hook preexec update_gpg_tty
add-zsh-hook chpwd   lsfn
