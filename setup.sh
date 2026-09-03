#!/usr/bin/env bash
#
# Symlink the files in this repo into $HOME.
# Existing files are moved to <name>.backup.<timestamp>, never deleted.
#
#   ./setup.sh            install
#   ./setup.sh --dry-run  print what would happen
#   ./setup.sh --force    replace existing symlinks without asking

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${HOME}"
STAMP="$(date +%Y%m%d%H%M%S)"
DRY_RUN=0
FORCE=0

# repo file -> name in $HOME
LINKS=(
    "zshrc:.zshrc"
    "bashrc:.bashrc"
    "aliases.sh:.shell_aliases"
)

for arg in "$@"; do
    case "$arg" in
        --dry-run) DRY_RUN=1 ;;
        --force)   FORCE=1 ;;
        -h|--help) sed -n '2,8p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
        *) echo "unknown option: $arg" >&2; exit 2 ;;
    esac
done

run() {
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "  would run: $*"
    else
        "$@"
    fi
}

for entry in "${LINKS[@]}"; do
    source_file="${REPO}/${entry%%:*}"
    dest="${TARGET}/${entry##*:}"

    if [ ! -f "$source_file" ]; then
        echo "skip ${entry##*:}: ${source_file} is missing" >&2
        continue
    fi

    if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$source_file" ]; then
        echo "ok   ${entry##*:} already linked"
        continue
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        if [ -L "$dest" ] && [ "$FORCE" -eq 1 ]; then
            run rm "$dest"
        else
            echo "move ${entry##*:} -> ${entry##*:}.backup.${STAMP}"
            run mv "$dest" "${dest}.backup.${STAMP}"
        fi
    fi

    echo "link ${entry##*:}"
    run ln -s "$source_file" "$dest"
done

echo
echo "Done. Open a new shell, or: source ~/.shell_aliases"
