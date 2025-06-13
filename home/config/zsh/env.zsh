export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

export ZLE_SPACE_SUFFIX_CHARS=$'&|'         # Avoid 'consuming' the space before a pipe or ampersand
export PARINIT="rTbgqR B=.,?'_A_a_@ Q=_s>|" # TODO: Figure out how to make this available to nvim shell

export MISE_CONFIG_FILE="$XDG_CONFIG_HOME/mise.toml"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

path=(
    "$HOME/local/bin"
    $path
    "$CARGO_HOME/bin"
    "$XDG_DATA_HOME/nvim/mason/bin"
    "$HOME/.luarocks/bin" # TODO: move luarocks stuff someplace else... (XDG_DATA_HOME/luarocks/bin ?)
)

export BROWSER="$(which google-chrome-stable)" # Just in case something might use it (like man --html)
export MANWIDTH=100
export MANOPT='--no-justification --no-hyphenation'
if [[ $(command -v nvim) ]]; then
  export EDITOR="nvim"
  export VISUAL="nvim"
  export MANPAGER='nvim +Man!'
fi

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --bind=ctrl-h:deselect+down
  --bind=ctrl-l:select+down
  --bind=ctrl-y:enter
  --prompt="> "
  --preview-window=noborder
  --separator=
  --scrollbar=█
  --pointer=█
  --marker=▌
'
