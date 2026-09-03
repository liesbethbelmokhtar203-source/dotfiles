# ~/.zshrc

# --- history ---
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY INC_APPEND_HISTORY

# --- shell behaviour ---
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS NO_BEEP
unsetopt CORRECT_ALL   # it "corrects" dbt into dd often enough to be a hazard

# --- completion ---
autoload -Uz compinit
compinit -C
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# --- prompt: cwd + git branch, two lines so long paths do not squeeze commands ---
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f%F{yellow}${vcs_info_msg_0_}%f
%(?.%F{green}.%F{red})>%f '

# --- keys ---
bindkey -e
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# --- environment ---
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export LESS='-FRX'
export LANG=en_US.UTF-8

# Keep dbt and Python quiet about things I cannot fix.
export PYTHONDONTWRITEBYTECODE=1
export DBT_PROFILES_DIR="$HOME/.dbt"

# --- path ---
typeset -U path
path=("$HOME/.local/bin" "$HOME/.cargo/bin" $path)

[ -f ~/.shell_aliases ] && . ~/.shell_aliases
[ -f ~/.zshrc.local ] && . ~/.zshrc.local   # machine specific, never committed
