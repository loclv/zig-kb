---
name: zig-syntax-overview
description: Core Zig syntax covering const/var declarations, function declarations, struct definitions, and doc comment conventions. Must use when reading or writing Zig files.
---

# Syntax Overview

Zig syntax is designed to be readable and explicit. It heavily borrows from C but cleans up many of its legacy issues.

## Variable Declarations

- `const`: Immutable value.
- `var`: Mutable value.

```zig
const constant_value: i32 = 5;
var mutable_value: i32 = 10;
mutable_value += 1;
```

## Functions

Functions are declared with the `fn` keyword.

```zig
pub fn add(a: i32, b: i32) i32 {
    return a + b;
}
```

## Structs

Structs are the primary way to organize data and methods.

```zig
const User = struct {
    id: u32,
    name: []const u8,

    pub fn print(self: User) void {
        std.debug.print("User {d}: {s}\n", .{self.id, self.name});
    }
};
```

## Comments

- `//`: Standard comment.
- `///`: Doc comment for the following symbol.
- `//!`: Doc comment for the current module.

Agent Tip: Zig uses `CamelCase` for types (including structs) and `snake_case` for functions and variables. Always specify types for clarity unless the inference is obvious.
