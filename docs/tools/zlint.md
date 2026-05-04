---
name: zig-linting-with-zlint
description: ZLint is an opinionated, high-performance linter for Zig with its own semantic analyzer. Must use when linting Zig projects, configuring lint rules via zlint.json, or setting up CI linting with disable directives.
---

# zlint

<https://github.com/DonIsaac/zlint> An opinionated linter for the Zig programming language.

## Features

- Custom semantic analyzer — independent of the Zig compiler, so it can lint dead code that Zig might eliminate.
- Fast — typically lints large projects in a few hundred milliseconds.
- Detailed diagnostics — pretty, actionable error messages with explanations and fix hints.

## Installation

### Pre-built binaries

Available for Windows, macOS, and Linux (x64 and aarch64) on the [releases page](https://github.com/DonIsaac/zlint/releases/latest).

### Install script

Linux / macOS:

```bash
curl -fsSL https://raw.githubusercontent.com/DonIsaac/zlint/refs/heads/main/tasks/install.sh | bash
```

Windows (PowerShell):

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/DonIsaac/zlint/refs/heads/main/tasks/install.ps1" | Invoke-Expression
```

### Build from source

```bash
zig build --release=safe
```

## Configuration (`zlint.json`)

Place `zlint.json` next to `build.zig` in your project root.

```json
{
  "rules": {
    "unsafe-undefined": "error",
    "homeless-try": "warn"
  }
}
```

Severity levels:
- `"error"` — reported as an error
- `"warn"` — reported as a warning
- `"off"` — rule disabled

>Note: A `zlint.json` file disables all default rules. Only rules explicitly listed are enabled.

## Disable Directives

ZLint supports ESLint-style comment directives to suppress rules in specific files or on specific lines.

### Disable for the rest of the file

```zig
// zlint-disable unsafe-undefined
const x: i32 = undefined;
```

### Disable with description

```zig
// zlint-disable unsafe-undefined -- We need to come back and fix this later
const x: i32 = undefined;
```

### Disable next line only

```zig
// zlint-disable-next-line unsafe-undefined
const x: i32 = undefined;
```

### Disable all rules

```zig
// zlint-disable
```

## CLI Usage

```bash
zlint [paths...]
```

When run without arguments, zlint lints the current directory recursively for `.zig` files.

## Lint Rules

All available rules and their descriptions are documented in the [zlint rules directory](https://github.com/DonIsaac/zlint/blob/main/docs/rules).
Notable rule categories include:

- Unsafe patterns — `unsafe-undefined`, unsafe type casts, missing error handling
- Style & conventions — naming, formatting, redundant constructs
- Semantic issues — homeless `try`, unused declarations, unreachable code

## Agent Tips

- Run `zlint` in CI to catch regressions before merge. It is fast enough to run on every commit.
- Start with defaults (no `zlint.json`) to get a baseline, then create `zlint.json` to customize severity levels.
- Use disable directives sparingly; add a `-- description` explaining why each suppression exists.
- Pair with `zig fmt` in CI: formatting fixes style, zlint catches semantic and structural issues.
