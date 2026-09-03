# ~/.bashrc
# Fallback shell. Most servers I get handed do not have zsh, so this exists.

# Only run for interactive shells.
case $- in
    *i*) ;;
      *) return ;;
esac

# --- history ---
HISTSIZE=50000
HISTFILESIZE=50000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT='%F %T '
shopt -s histappend cmdhist
PROMPT_COMMAND='history -a'

# --- shell behaviour ---
shopt -s checkwinsize globstar autocd 2>/dev/null

# --- prompt: cwd + git branch, red marker on non-zero exit ---
__git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's/^/ (/;s/$/)/'
}
PS1='\[\e[34m\]\w\[\e[0m\]\[\e[33m\]$(__git_branch)\[\e[0m\]\n\$ '

# --- environment ---
export EDITOR=${EDITOR:-vim}
export PAGER=less
export LESS='-FRX'
export PYTHONDONTWRITEBYTECODE=1
export DBT_PROFILES_DIR="$HOME/.dbt"

# --- path ---
case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) PATH="$HOME/.local/bin:$PATH" ;;
esac
export PATH

# --- completion ---
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

[ -f ~/.shell_aliases ] && . ~/.shell_aliases
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
