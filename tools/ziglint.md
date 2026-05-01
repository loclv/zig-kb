---
name: zig-linting-with-ziglint
description: ziglint rule reference, configuration via .ziglint.zon, inline ignores, and CLI usage. Must use when enforcing style, catching common anti-patterns, or setting up CI linting for Zig projects.
---

# ziglint

<https://github.com/rockorager/ziglint> A linter for Zig source code that enforces naming conventions, catches redundant patterns, flags unused declarations, and maintains stylistic consistency across a codebase.

## Installation & Usage

```bash
ziglint [options] [paths...]
```

When run without arguments, ziglint searches for a `.ziglint.zon` config file and uses the paths declared there, falling back to the current directory.
Directories are scanned recursively for `.zig` files.

### CLI Options

- `--zig-lib-path <path>` — Override the path to the Zig standard library (auto-detected from `zig env` if omitted).
- `--only <code>` — Lint only the specified rule (e.g., `Z001`). Can be repeated.
- `--ignore <code>` — Ignore a rule (e.g., `Z001`). Can be repeated.
- `-h, --help` — Show help message.

## Configuration (`~/.ziglint.zon`)

Create `.ziglint.zon` in the project root to configure paths and rules:

```zig
.{
    // Paths to lint (default: current directory)
    .paths = .{
        "src",
        "build.zig",
    },

    // Per-rule configuration
    .rules = .{
        // Disable a rule entirely
        .Z001 = .{ .enabled = false },

        // Configure rule-specific settings
        .Z024 = .{ .max_length = 80 },
    },
}
```

## Inline Ignores

Suppress rules on a per-line or next-line basis using comments:

```zig
fn MyBadName() void {} // ziglint-ignore: Z001

// ziglint-ignore: Z001
fn AnotherBadName() void {}
```

## Rules Reference

| Code | Description |
|---|---|
| **Z001** | Function names should be `camelCase`. |
| **Z002** | Unused variable that has a value. |
| **Z003** | Parse error. |
| **Z004** | Prefer `const x: T = .{}` over `const x = T{}`. |
| **Z005** | Type function names should be `PascalCase`. |
| **Z006** | Variable names should be `snake_case`. |
| **Z007** | Duplicate import. |
| **Z009** | Files with top-level fields should be `PascalCase`. |
| **Z010** | Redundant type specifier; prefer `.value` over explicit type. |
| **Z011** | Deprecated method call. |
| **Z012** | Public function exposes private type. |
| **Z013** | Unused import. |
| **Z014** | Error set names should be `PascalCase`. |
| **Z015** | Public function exposes private error set. |
| **Z016** | Split compound assert: `assert(a and b)` → `assert(a); assert(b);`. |
| **Z017** | Redundant `try` in return: `return try expr` → `return expr`. |
| **Z018** | Redundant `@as` when type is already known from context. |
| **Z019** | `@This()` in named struct; use the type name instead. |
| **Z020** | Inline `@This()`; assign to a constant first. |
| **Z021** | File-struct `@This()` alias should match filename. |
| **Z022** | `@This()` alias in anonymous/local struct should be `Self`. |
| **Z023** | Parameter order: `comptime` before runtime, pointers before values. |
| **Z024** | Line exceeds maximum length (default: `120`). |
| **Z025** | Redundant `catch | err | return err`; use `try` instead. |
| **Z026** | Empty `catch` block suppresses errors. |
| **Z027** | Access declaration through type instead of instance. |
| **Z028** | Inline `@import`; assign to a top-level `const`. |
| **Z029** | Redundant `@as` cast; type already known from context. |
| **Z030** | `deinit` should set `self.* = undefined`. |
| **Z031** | Avoid underscore prefix in identifiers. |
| **Z032** | Acronyms should use standard casing. |
| **Z033** | Avoid redundant words in identifiers (disabled by default). |

## Agent Tips

- Run `ziglint` in CI to catch style regressions before merge.
- Use `--only` to incrementally introduce rules into an existing codebase.
- Prefer `.ziglint.zon` over CLI flags so all contributors share the same configuration.
- For large refactors, temporarily disable `Z024` (line length) to reduce noise, then re-enable afterward.
