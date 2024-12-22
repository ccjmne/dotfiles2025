export ZLE_SPACE_SUFFIX_CHARS=$'&|'         # Avoid 'consuming' the space before a pipe or ampersand
export PARINIT="rTbgqR B=.,?'_A_a_@ Q=_s>|" # TODO: Figure out how to make this available to nvim shell

if [[ $(command -v nvim) ]]; then
  export EDITOR="nvim"
  export VISUAL="nvim"
  export MANPAGER='nvim +Man!'
fi

export MISE_CONFIG_FILE="$XDG_CONFIG_HOME/mise.toml"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

path=(
    "$HOME/.local/bin"
    $path
    "$CARGO_HOME/bin"
    "$XDG_DATA_HOME/nvim/mason/bin"
)
