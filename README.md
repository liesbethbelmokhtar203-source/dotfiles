<div align="center">

# dotfiles

**Shell configuration that is the same on every machine I work on — which is the entire point.**

[![shell](https://img.shields.io/badge/shell-bash%20%7C%20zsh-black?style=flat-square&logo=gnubash)](#quick-start)
[![license](https://img.shields.io/badge/license-MIT-green?style=flat-square)](LICENSE)

</div>

## About

Nothing exotic, but it is identical on every machine, and `setup.sh` is
written to be run twice without damage: it never deletes anything, moves an
existing file to `<name>.backup.<timestamp>` first, and reports what is already
linked and stops there.

A handful of helpers carry most of the value: `peek export.csv` (first 20 rows
of any csv/parquet/json via duckdb), `rows big.parquet` (row count without
opening pandas), and dbt aliases that are always scoped to a selector rather
than bare.

## Quick start

```bash
git clone https://github.com/liesbethbelmokhtar203-source/dotfiles ~/.dotfiles
cd ~/.dotfiles
./setup.sh --dry-run   # see what it would do
./setup.sh
```

## Configuration

| Key | Description |
| --- | --- |
| `zshrc → ~/.zshrc` | history, completion, two-line prompt with git branch |
| `bashrc → ~/.bashrc` | the same idea for servers without zsh |
| `aliases.sh → ~/.shell_aliases` | shared aliases and a few helper functions |
| `setup.sh` | symlinks the three files into `$HOME`, `--dry-run` supported |
| `~/.zshrc.local / ~/.bashrc.local` | sourced at the end if present, never tracked here |
## Roadmap

- [ ] Zsh completion for the helper functions
- [ ] Per-host overrides documented end to end
- [ ] Shellcheck in CI

## Contributing

Issues and pull requests are welcome. Please keep changes small and focused,
and add a test for any behaviour change — every repository here ships with a
runnable test suite and no third-party dependencies, so CI is just
`python3 -m unittest` / `bash test_*.sh`.

## License

[MIT](LICENSE)
