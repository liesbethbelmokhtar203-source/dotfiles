# dotfiles

My shell configuration. Nothing exotic, but it is the same on every machine I
work on, which is the entire point.

## What is in here

| File | Links to | What it does |
|------|----------|--------------|
| `zshrc` | `~/.zshrc` | history, completion, two-line prompt with git branch |
| `bashrc` | `~/.bashrc` | the same idea for servers without zsh |
| `aliases.sh` | `~/.shell_aliases` | shared aliases and a few helper functions |
| `setup.sh` | - | symlinks the three files into `$HOME` |

## Install

```sh
git clone https://github.com/liesbethbelmokhtar203-source/dotfiles ~/.dotfiles
cd ~/.dotfiles
./setup.sh --dry-run   # see what it would do
./setup.sh
```

`setup.sh` never deletes anything. If `~/.bashrc` already exists it is moved to
`~/.bashrc.backup.20240301120000` first. Running it twice is safe, it reports
what is already linked and stops there.

## Usage

Everything is loaded on the next shell. A few of the helpers:

```sh
peek export.csv        # first 20 rows of any csv/parquet/json, via duckdb
peek export.csv 100    # ... or 100
rows big.parquet       # row count without opening it in pandas
dbtb stg_orders+       # dbt build --select stg_orders+
gs                     # git status --short --branch
```

`peek` and `rows` need [duckdb](https://duckdb.org) on the PATH. Everything else
is plain shell.

## Local overrides

`~/.zshrc.local` and `~/.bashrc.local` are sourced at the end if they exist and
are not tracked here. Client-specific paths, credentials, and per-machine
settings go there, not in this repo.

## License

MIT.
