setopt interactive_comments   # Allow comments in interactive shell
setopt nocaseglob             # Case insensitive globbing (used in pathname expansion)


# History-related opts =========================================================

HISTFILE="$ZDOTDIR/history"
HISTSIZE=50000
SAVEHIST=10000

setopt hist_verify            # Show command with history expansion before running

setopt hist_ignore_dups       # Ignore duplicate commands history list
setopt hist_ignore_all_dups   # Delete old recorded dupes
setopt hist_find_no_dups      # Do not display a line previously found

setopt hist_no_functions      # Don't store function definitions in history
setopt hist_no_store          # Don't store command in history if it starts with a space
setopt hist_save_no_dups      # Don't write duplicate entries in the history file
setopt hist_expire_dups_first # Expire a duplicate first when trimming history

setopt appendhistory          # Append history to the history file (no overwriting)
setopt inc_append_history     # Immediately append to the history file, not just when a term is killed
setopt share_history          # Share history between terminals


# cd-related opts ==============================================================

setopt auto_cd                # Attempt to cd on failing command corresponding to an existing directory
setopt auto_pushd             # Push the current directory visited on the stack
setopt cd_silent              # Do not print the directory stack after pushd or popd
setopt pushd_silent           # Do not print the directory stack after pushd or popd
setopt pushd_ignore_dups      # Do not store duplicates in the stack
setopt pushdminus             # Switch '+' and '-' when used with a number to specify a stack entry
