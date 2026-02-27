<!-- markdownlint-configure-file {"MD024": { "siblings_only": true } } -->

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [unreleased]

## [0.0.2] - 2026-02-27

### Added

- Full MakeMKV selection syntax per [forum spec](https://forum.makemkv.com/forum/viewtopic.php?t=4386):
  `+sel`/`-sel`/`+N`/`-N`/`=N` actions; `|` `&` `*` `!` `~` operators; Not conditional.
- Condition tokens: `video`, `lossy`, `lossless`, `havelossless`, `forced`;
  `N` (nth track, with 1st/2nd/3rd ordinals); generic 3-letter ISO 639 language codes;
  `single`, `core`, `havemulti`, `havecore`; top 30 languages plus Cantonese (`yue`) and Dutch (`nld`).
- Structured translation: numbered top-level list; nested sublists with `|` and `&` bullets for OR/AND;
  “not” for negated conditions.
- Collapsible syntax reference with headers and bullets; clickable keywords append to the input and
  focus it with cursor at end.
- Friendly parse error messages; input shows error outline when parse fails.
- Persistence: syntax reference open/closed state in `localStorage`; last successful selection in
  `sessionStorage` (restored on load).
- Bootstrap 5 styling and dark theme (`data-bs-theme="dark"`).
- GitHub Pages workflow; live demo at <https://tatsh.github.io/makemkv-selection-translator/>.
- Live demo link in README.

### Changed

- Parser requires `+sel`/`-sel` for select/unselect (no optional `sel`).
- Translation output is a numbered list with nested bullet sublists instead of comma-separated text.

## [0.0.1] - 2026-02-24

First version.

[unreleased]: https://github.com/Tatsh/makemkv-selection-translator/compare/v0.0.2...HEAD
[0.0.2]: https://github.com/Tatsh/makemkv-selection-translator/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/Tatsh/makemkv-selection-translator/releases/tag/v0.0.1
