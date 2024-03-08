﻿# install with scoop:
# git
# fzf
# PSfzf
# starship

# config as a git alias for managing dotfiles
function config { & git --git-dir=$HOME\.cfg\ --work-tree=$HOME $args}

# go to C and D drive
function cdc { & cd C:\ }
function cdd { & cd D:\ }

#fzf integration:
# Ctrl+t to paste file path
# Ctrl+r to search history
# Alt+c to cd to directory
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# prompt
Invoke-Expression (&starship init powershell)