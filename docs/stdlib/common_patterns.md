---
name: zig-stdlib-patterns
description: Common Zig standard library patterns for printing, ArrayList usage, string formatting, hashing, and crypto operations. Must use when reading or writing Zig files that use std.
---

# Standard Library Patterns

Commonly used patterns in the Zig standard library (`std`).

## Printing
Use `std.debug.print` for debugging and `std.io.getStdOut().writer()` for production output.

```zig
const std = @import("std");
std.debug.print("Hello, {s}!\n", .{"world"});
```

## ArrayList
A dynamic array.

```zig
var list = std.ArrayList(u32).init(allocator);
defer list.deinit();
try list.append(1);
```

## String Formatting
Use `std.fmt.allocPrint` to create strings on the heap.

```zig
const message = try std.fmt.allocPrint(allocator, "Score: {d}", .{score});
defer allocator.free(message);
```

## Hashing and Crypto
`std.crypto` contains many modern algorithms.

```zig
var hash: [std.crypto.hash.sha2.Sha256.digest_length]u8 = undefined;
std.crypto.hash.sha2.Sha256.hash("input data", &hash, .{});
```

Agent Tip: The Zig standard library source code is very readable. If you are unsure how a module works, look at its source (usually in `lib/std/`). Use `std.mem` for byte-level operations.
