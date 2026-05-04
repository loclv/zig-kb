---
name: zig-testing-patterns
description: Zig testing framework, the test keyword, std.testing.expect, and test allocators. Must use when writing unit tests in Zig.
---

# Testing Patterns

Zig has a built-in testing framework. Tests are defined using the `test` keyword followed by a string name and a block of code.

## The `test` Keyword

Tests are executed only when using `zig test`. They are entirely ignored during regular executable or library builds.

```zig
const std = @import("std");

fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "basic addition" {
    try std.testing.expect(add(2, 3) == 5);
}
```

## std.testing

The `std.testing` namespace provides several utilities for assertions:
- `expect(ok: bool)`: Fails the test if `ok` is false.
- `expectEqual(expected, actual)`: Compares two values.
- `expectError(expected_err, actual_err_union)`: Asserts an error union resolves to the expected error.

```zig
const std = @import("std");
const testing = std.testing;

test "expectEqual" {
    try testing.expectEqual(@as(i32, 42), 42);
}
```

## Testing Allocator

To catch memory leaks in tests, always use `std.testing.allocator` instead of `GeneralPurposeAllocator` or `page_allocator`. It tracks allocations and will fail the test if any memory is leaked.

```zig
const std = @import("std");

test "memory leak detection" {
    const allocator = std.testing.allocator;
    const ptr = try allocator.create(i32);
    // defer allocator.destroy(ptr); // Uncomment to fix the leak
    ptr.* = 42;
}
```

## Agent Tips

- **Top-level tests**: Tests must be at the top level of a file, or within a struct/union/enum. However, tests inside nested namespaces will not be discovered automatically unless they are referenced using `std.testing.refAllDecls`.
- **Use `@as` in expectEqual**: `expectEqual` requires the expected and actual values to be of the *exact same type*. Use `@as(Type, value)` for the expected value to coerce it properly and avoid type mismatch compilation errors.
