# Native installation verification

Verified on 3 October 2026 on an Apple M1 Pro (`arm64`), using the latest stable
homebrew-core formulas available after `brew update`:

| Tool | Installed version | Compiler settings confirmed in build logs |
| --- | --- | --- |
| Vim | 9.2.1150 | `-O3 -mcpu=apple-m1` |
| Git | 2.56.0 | `-O3 -mcpu=apple-m1` |
| ripgrep | 15.2.0 | `-C target-cpu=apple-m1`, fat LTO, one codegen unit |
| Universal Ctags | 6.2.1 | `-O3 -mcpu=apple-m1` |

The external `brew native` command performed the source installations. All four
receipts identify `marianposaceanu/tap`, with `poured_from_bottle: false` and
`built_as_bottle: false`. All executables are arm64 and all four formulas are
pinned. Required dependencies were installed or upgraded as normal bottles.

The tests passed for every installed formula:

```sh
brew test marianposaceanu/tap/vim marianposaceanu/tap/git \
  marianposaceanu/tap/ripgrep marianposaceanu/tap/universal-ctags
```

Additional checks exercised Vim's Python 3, Ruby, and Lua interpreters; ripgrep
PCRE2 lookbehind and Unicode matching; Ctags C and Ruby parsers with JSON output;
and Git commit, show, blame, and strict fsck in a temporary repository.
`bb bootstrap/checks/check_configs.clj` passed in the dot-files repository.
These checks establish installation and behavior, not a performance improvement.
The earlier published benchmarks used their recorded versions and build modes.

## Verify a later installation

```sh
brew update
brew native
brew list --versions vim git ripgrep universal-ctags
brew list --pinned
"$(brew --prefix marianposaceanu/tap/vim)/bin/vim" --version
brew test marianposaceanu/tap/vim marianposaceanu/tap/git \
  marianposaceanu/tap/ripgrep marianposaceanu/tap/universal-ctags
```

Check each active keg's `INSTALL_RECEIPT.json` via `brew --prefix`, rather than
choosing an arbitrary older version in the Cellar. Inspect compiler invocations
in `~/Library/Logs/Homebrew/{vim,git,ripgrep,universal-ctags}/`. ripgrep's verbose
Cargo log records `rustc` CPU, optimization, and LTO arguments. Its PCRE2 feature
uses the declared Homebrew PCRE2 dependency; this does not rebuild that dependency
with native flags.

Use the keg's absolute executable path if another application shadows it in
`PATH`. Codex's bundled `rg` shadowed Homebrew's ripgrep during this verification;
the source-build verification used the Homebrew keg directly.

Git's standard-environment build explicitly uses `/usr/bin/perl` and probes that
same interpreter for module paths. Inheriting a Homebrew Perl from `PATH` caused
the upstream `git send-email` TLS test to fail because its SSL module was missing.
Rebuilding with macOS Perl fixed the test without weakening the upstream checks.
