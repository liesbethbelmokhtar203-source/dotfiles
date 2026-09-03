# Shared aliases and small helpers.
# Sourced by both zshrc and bashrc, so keep this POSIX-ish.

# --- files and navigation ---
alias ll='ls -lh --group-directories-first'
alias la='ls -lAh --group-directories-first'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'

# --- git ---
alias gs='git status --short --branch'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate -20'
alias gp='git pull --rebase --autostash'
alias gb='git branch --sort=-committerdate'

# --- dbt ---
# Almost every dbt command I run is scoped to something, so no bare aliases.
alias dbtb='dbt build --select'
alias dbtr='dbt run --select'
alias dbtt='dbt test --select'
alias dbtf='dbt build --select state:modified+ --defer --state ./target-base'
alias dbtdocs='dbt docs generate && dbt docs serve --port 8081'

# --- containers ---
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f --tail=100'

# --- python ---
alias venv='python3 -m venv .venv && . .venv/bin/activate && pip install -U pip'
alias act='. .venv/bin/activate'

# Peek at any tabular file with DuckDB. Works for csv, parquet, json.
peek() {
    if [ -z "$1" ]; then
        echo "usage: peek <file> [limit]" >&2
        return 1
    fi
    duckdb -c "SELECT * FROM '$1' LIMIT ${2:-20};"
}

# Row count without loading the file into pandas.
rows() {
    duckdb -c "SELECT count(*) AS rows FROM '$1';"
}

# Make a directory and step into it.
mkcd() {
    mkdir -p "$1" && cd "$1" || return 1
}
