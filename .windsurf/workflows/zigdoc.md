---
description: Look up Zig symbol documentation using zigdoc CLI
---

# zigdoc Skill

Use this skill when you need to look up documentation for Zig standard library symbols, third-party module symbols, or when verifying API signatures and doc comments without leaving the editor.

## When to Use

- You need to check the signature or doc comments of a Zig std symbol (e.g., `std.ArrayList`, `std.mem.Allocator`).
- You want to explore a third-party dependency's API that is imported in `build.zig`.
- You are unsure about a function's parameters, return type, or available methods.
- You need to verify module imports are correctly exposed.

## Steps

1. Identify the symbol path (e.g., `std.ArrayList`, `std.mem.Allocator`, `vaxis.Window`).
2. Run zigdoc:
   ```bash
   zigdoc <symbol>
   ```

3. Read the output for:
   - File location
   - Category (type_function, type, etc.)
   - Signature
   - Doc comments
   - Source snippet

4. For third-party modules, verify the module is imported in `build.zig` first. If unsure, run:
   ```bash
   zigdoc --dump-imports
   ```

## Example Queries

```bash
zigdoc std.ArrayList
zigdoc std.mem.Allocator
zigdoc std.http.Server
zigdoc vaxis.Window
zigdoc zeit.timezone.Posix
```

## Tips

- Combine with shell aliases for speed: `alias zd='zigdoc'`.
- Use `--dump-imports` to debug missing module access.
- For project scaffolding, use `zigdoc @init` to create a new project with `AGENTS.md` and `ziglint` preconfigured.
