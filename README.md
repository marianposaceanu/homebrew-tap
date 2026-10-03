# Marian's Homebrew tap

Homebrew formulae for Marian Posaceanu's tools.

## mextdisplay

Install the external display manager for Apple Silicon Macs:

```sh
brew tap marianposaceanu/tap
brew install mextdisplay
```

Run `mextdisplay` to open the terminal UI.

## rz

Install the native Ghostty workspace manager for macOS:

```sh
brew tap marianposaceanu/tap
brew install rz
```

Run `rz --help` to see the snapshot, restore, watcher, and cleanup commands.

## Native Apple Silicon builds

The `Formula/` directory also includes native source-build variants of Vim, Git,
ripgrep, and Universal Ctags. These formulas require Apple Silicon macOS, use
`env :std`, and have no bottles. Committed formulas target the build machine via
`-mcpu=native`; ripgrep also uses `RUSTFLAGS=-C target-cpu=native` and the
`release-lto` profile. Use fully qualified formula names to select this tap.

```sh
brew tap marianposaceanu/tap
brew update                              # refresh upstream formula versions
brew native                         # all four tools
brew native vim ripgrep             # selected tools
brew native --formulas-only         # refresh Formula/*.rb without building
```

`cmd/brew-native` delegates to `native/brew_native.sh`. You can run the latter
from a checkout as well:

```sh
./native/brew_native.sh --help
./native/brew_native.sh --formulas-only
```

The helper copies current homebrew-core formulas, removes their bottle blocks,
and injects native flags. Build mode resolves the concrete local Apple CPU;
`--formulas-only` defaults to `native` for portable committed snapshots.
`NATIVE_CPU=apple-m1` overrides either mode. It then synchronizes formulas to the
installed tap. Build mode replaces existing core or tap kegs using explicit
uninstall/install operations and pins the installed tools. Formula regeneration
modifies local tap files; inspect the diff before committing upstream updates.

For a maintained formula refresh, run `--formulas-only` in your development
checkout, review `git diff -- Formula/`, and commit the refreshed formulas.
After publication, users can obtain the refresh with `brew update` and rebuild.
For an individual published formula, uninstall its existing keg first and then
use, for example, `brew install --build-from-source marianposaceanu/tap/vim`.

See [the M1 Pro installation verification](native/INSTALLATION.md) for tested versions, compiler evidence, and repeatable checks. Git explicitly uses macOS Perl so the standard environment preserves its SSL module support. Cargo uses verbose logging to record the actual Rust compiler flags.

Restore stock bottles with:

```sh
for tool in vim git ripgrep universal-ctags; do
  brew unpin "$tool"
  brew uninstall --ignore-dependencies "$tool"
  brew install "homebrew/core/$tool"
done
```

## Legacy native builds and benchmarks

`native/compile_*_native.sh` preserves the earlier binary-replacement builds,
including their existing PGO options. These are optional tools; they do not run
when you install `mextdisplay` or `rz`. Git, ripgrep, and Ctags training and
verification call benchmarks from the dot-files repository:

```sh
DOT_FILES_REPO=~/dot-files ./native/compile_ripgrep_native.sh --pgo
```

`DOT_FILES_REPO` defaults to `~/dot-files`. Dotfiles' compatibility launchers set
it to their own repository automatically. The `NATIVE_TAP_ROOT` override on those
launchers selects a development checkout instead of the installed tap.
