#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# completion behaviour
bind 'set show-all-if-ambiguous on'         # show matching completions
bind 'set menu-complete-display-prefix on'  # complete only common part on first press
bind 'TAB:menu-complete'                    # cycle through available completions after
bind 'set colored-stats on'  # completion menu is colored (dirs, executables)
bind 'set colored-completion-prefix on'  # search string is colored in menu

# dotfile management with config as a git alias
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Haskell
[ -f "/c/ghcup/env" ] && . "/c/ghcup/env" # ghcup-env

# ls colors
LS_COLORS="$LS_COLORS:ow=1;34;47:"
alias ls='ls --color=auto --group-directories-first'

#less
export LESS='-MRi#8j.5'
#             |||| `- center on search matches
#             |||`--- scroll horizontally 8 columns at a time
#             ||`---- case-insensitive search unless pattern contains uppercase
#             |`----- parse color codes
#             `------ show more information in promp

# grep
alias grep='grep --color --binary-files=without-match --exclude-dir .git'

# git
alias g='git'
complete -o default -o nospace -F _git g
. /usr/share/bash-completion/completions/git 2> /dev/null

# vim
alias v='vim'

# make directory and go there
mkcd() {
    mkdir "$@" && cd "$@"
}

# SETTINGS

# shell history is useful, let's have more of it
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoredups   # don't store duplicated commands
shopt -s histappend # don't overwrite history file after each session

# run cnf on unknown command (openSUSE)
export COMMAND_NOT_FOUND_AUTO=1


# Prompt

# custom virtualenv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
virtualenv_info() {
    [[ -n "$VIRTUAL_ENV_PROMPT" ]] && echo "(\[\033[0;31m\]${VIRTUAL_ENV_PROMPT##*/}\[\033[0m\]) "
}

# wsl check
wsl_info() {
    [[ -f "/etc/wsl.conf" ]] && echo "\[\033[1;32m\]WSL\[\033[0m\]:"
}

# custom git prompt
git_info() {
    local DIRTY="\[\033[0;33m\]"
    local CLEAN="\[\033[0;32m\]"
    local UNMERGED="\[\033[0;31m\]"
    git rev-parse --git-dir >& /dev/null
    if [[ $? == 0 ]]; then
        echo -n " "
        if [[ `git ls-files -u >& /dev/null` == '' ]]; then
            git diff --quiet >& /dev/null
            if [[ $? == 1 ]]
            then
                echo -n $DIRTY
            else
                git diff --cached --quiet >& /dev/null
                if [[ $? == 1 ]]; then
                    echo -n $DIRTY
                else
                    echo -n $CLEAN
                fi
            fi
        else
            echo -n $UNMERGED
        fi
        echo -n `git branch | grep '* ' | sed 's/..//'`
        echo -n "\[\033[0m\]"
    fi
}

#PS1='[\u@\h \W]\$ '

set_bash_prompt(){
	PS1="$(virtualenv_info)$(wsl_info)\[\033[1;36m\]\w\[\033[0m\]$(git_info)> "
}

PROMPT_COMMAND=set_bash_prompt

# FZF fuzzy file search for fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
