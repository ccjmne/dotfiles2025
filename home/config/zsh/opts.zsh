setopt INTERACTIVE_COMMENTS     # Allow comments in interactive shell
setopt NOCASEGLOB               # Case insensitive globbing (used in pathname expansion)

# History-related opts
# --------------------
SAVEHIST=8192                   # Maximum number of entries in $HISTFILE size
HISTSIZE=16384                  # Maximum number of entries in memory
HISTFILE="$ZDOTDIR/history"

setopt APPEND_HISTORY           # Append history to the history file (no overwriting)
setopt EXTENDED_HISTORY         # Remove superfluous blanks from history entries
setopt HIST_FIND_NO_DUPS        # Do not display a line previously found
setopt HIST_IGNORE_ALL_DUPS     # Delete old recorded dupes
setopt HIST_IGNORE_DUPS         # Ignore duplicate commands history list
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks from history entries
setopt HIST_SAVE_NO_DUPS        # Don't write duplicate entries in the history file
setopt INC_APPEND_HISTORY_TIME  # Append to $HISTFILE upon command completion, not only on session close

# cd-related opts
# ---------------
setopt AUTO_CD                  # Attempt to cd on failing command corresponding to an existing directory
setopt AUTO_PUSHD               # Push the current directory visited on the stack
setopt CD_SILENT                # Do not print the directory stack after pushd or popd
setopt PUSHD_SILENT             # Do not print the directory stack after pushd or popd
setopt PUSHD_IGNORE_DUPS        # Do not store duplicates in the stack
setopt PUSHDMINUS               # Switch '+' and '-' when used with a number to specify a stack entry
