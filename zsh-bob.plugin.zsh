#!/usr/bin/env zsh
# shellcheck disable=SC1090

# Exit if the 'bob' command can not be found
if ! (( $+commands[bob] )); then
    return
fi

# Add the 'bob' nvim-bin directory to the path
typeset -TUx PATH path
path=("$HOME/.local/share/bob/nvim-bin" $path)

# Completions directory for `bob` command
local COMPLETIONS_DIR="${0:A:h}/completions"

# Add completions to the FPATH
typeset -TUx FPATH fpath
fpath=("$COMPLETIONS_DIR" $fpath)

# If the completion file does not exist yet, then we need to autoload
# and bind it to `bob`. Otherwise, compinit will have already done that.
if [[ ! -f "$COMPLETIONS_DIR/_bob" ]]; then
    typeset -g -A _comps
    autoload -Uz _bob
    _comps[bob]=_bob
fi

# Generate and load completion in the background
bob complete zsh >| "$COMPLETIONS_DIR/_bob" &|