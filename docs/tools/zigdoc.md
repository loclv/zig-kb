---
name: zig-documentation-with-zigdoc
description: CLI tool for browsing Zig standard library and third-party module documentation from the terminal. Must use when looking up symbol signatures, doc comments, or exploring APIs without leaving the editor.
---

# zigdoc

<https://github.com/rockorager/zigdoc> A command-line tool to view documentation for Zig standard library symbols and imported modules.

## Installation

```bash
zig build install -Doptimize=ReleaseFast --prefix $HOME/.local
```

## Usage

```
Usage: zigdoc [options] <symbol>

Show documentation for Zig standard library symbols and imported modules.

zigdoc can access any module imported in your build.zig file, making it easy
to view documentation for third-party dependencies alongside the standard library.

Examples:
  zigdoc std.ArrayList
  zigdoc std.mem.Allocator
  zigdoc std.http.Server
  zigdoc vaxis.Window
  zigdoc zeit.timezone.Posix

Options:
  -h, --help        Show this help message
  --dump-imports    Dump module imports from build.zig as JSON

Commands:
  @init             Initialize a new Zig project with AGENTS.md
```

## Looking Up Symbols

Query the standard library by symbol path:

```bash
zigdoc std.ArrayList
zigdoc std.mem.Allocator
zigdoc std.http.Server
```

Output includes:
- Symbol name
- File location
- Category (e.g., `type_function`)
- Signature
- Doc comments
- Source snippet

### Third-Party Modules

Any module imported in `build.zig` is accessible:

```bash
zigdoc vaxis.Window
zigdoc zeit.timezone.Posix
```

## Project Initialization (`@init`)

Scaffold a new project with `build.zig`, `build.zig.zon`, and an `AGENTS.md` file pre-configured for `ziglint`:

```bash
mkdir my-project && cd my-project
zigdoc @init
```

## Options

| Flag | Description |
|---|---|
| `-h, --help` | Show help message. |
| `--dump-imports` | Dump module imports from `build.zig` as JSON. |

## Agent Tips

- Use `zigdoc` instead of switching to a browser to keep flow inside the terminal.
- Combine with `grep` or shell aliases for quick lookups: `alias zd='zigdoc'`.
- Run `--dump-imports` to verify that third-party modules are correctly exposed in `build.zig`.
- `@init` is a fast way to spin up a project with linting and agent documentation already wired.
