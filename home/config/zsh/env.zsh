export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"  # Supposedly omz-only but others (like mise) appear to use it too
export ZLE_SPACE_SUFFIX_CHARS=$'&|'         # Avoid 'consuming' the space before a pipe or ampersand
export PARINIT="rTbgqR B=.,?'_A_a_@ Q=_s>|" # TODO: Figure out how to make this available to nvim shell

export MISE_CONFIG_FILE="$XDG_CONFIG_HOME/mise.toml"

path=(
    "$HOME/local/bin"
    $path
    "$XDG_DATA_HOME/nvim/mason/bin"
)

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export LUAROCKS_HOME="$XDG_DATA_HOME/luarocks"
export LUA_PATH="$LUAROCKS_HOME/share/lua/5.4/?.lua;$LUAROCKS_HOME/share/lua/5.4/?/init.lua;;"
export LUA_CPATH="$LUAROCKS_HOME/lib/lua/5.4/?.so;;"
[[ -d "$CARGO_HOME/bin"    ]] && path+=("$CARGO_HOME/bin")
[[ -d "$PNPM_HOME/bin"     ]] && path+=("$PNPM_HOME/bin")
[[ -d "$LUAROCKS_HOME/bin" ]] && path+=("$LUAROCKS_HOME/bin")

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
  --bind=ctrl-y:accept
  --prompt="> "
  --preview-window=noborder
  --separator=
  --scrollbar=█
  --pointer=█
  --marker=▌
'
