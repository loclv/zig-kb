---
name: zig-error-handling
description: Zig error handling with explicit error sets, error union types (!), try/catch/if err patterns, and best practices for error propagation. Must use when reading or writing Zig files.
---

# Error Handling

In Zig, errors are values and must be handled explicitly.

## Error Sets
An error set is like an enum.

```zig
const FileError = error{
    FileNotFound,
    AccessDenied,
    OutOfMemory,
};
```

## The `!` operator
The `!` operator creates an error union type. `!i32` means the value is either an `i32` or an error.

```zig
fn parseNumber(s: []const u8) !i32 {
    return std.fmt.parseInt(i32, s, 10);
}
```

## `try`, `catch`, and `if`

### `try`
Unwraps a value or returns the error from the current function.

```zig
const val = try parseNumber("123");
```

### `catch`
Provides a default value or handles the error.

```zig
const val = parseNumber("abc") catch 0;
const val2 = parseNumber("abc") catch |err| {
    std.debug.print("Error: {}\n", .{err});
    return err;
};
```

### `if (err_union)`
Pattern matching for errors.

```zig
if (parseNumber("123")) |val| {
    // use val
} else |err| {
    // handle err
}
```

Agent Tip: Avoid ignoring errors with `catch unreachable` unless you are absolutely certain (e.g., in a test or a proven-safe invariant). Always bubble up errors with `try` when possible to keep functions flexible.
