#!/usr/bin/env zsh
# shellcheck disable=SC1090

# Exit if the 'bob' command can not be found
if ! (( $+commands[bob] )); then
    echo "ERROR: 'bob' command not found"
    return
fi

# Add the 'bob' nvim-bin directory to the path
typeset -TUx PATH path
path=("$HOME/.local/share/bob/nvim-bin" $path)

# Completions directory for `bob` command
local COMPLETIONS_DIR="${0:A:h}/completions"

# Only regenerate completions if older than 24 hours, or does not exist
if [[ ! -f "$COMPLETIONS_DIR/_bob"  ||  ! $(find "$COMPLETIONS_DIR/_bob" -newermt "24 hours ago" -print) ]]; then
    bob complete zsh >| "$COMPLETIONS_DIR/_bob"
fi

# Add completions to the FPATH
typeset -TUx FPATH fpath
fpath=("$COMPLETIONS_DIR" $fpath)
