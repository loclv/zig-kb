---
name: zig-language-server
description: The official Language Server Protocol implementation for Zig, providing completions, hover, goto definition, formatting, and semantic highlighting. Must use when setting up IDE support or editor integration for Zig development.
---

# ZLS — Zig Language Server

ZLS is the official Language Server Protocol (LSP) implementation for Zig, written in Zig.

## Installation

```bash
git clone https://github.com/zigtools/zls
cd zls
zig build -Doptimize=ReleaseSafe
```

See [zigtools.org/zls/install/](https://zigtools.org/zls/install/) for editor-specific setup and prebuilt binaries.

## Supported LSP Features

- Completions
- Hover
- Goto definition / declaration
- Document symbols
- Find references
- Rename symbol
- Formatting via `zig fmt`
- Semantic token highlighting
- Inlay hints
- Code actions
- Selection ranges
- Folding regions

## Notes

- Keep ZLS version synchronized with your Zig compiler version.
- Comptime and full semantic analysis support is work-in-progress.
