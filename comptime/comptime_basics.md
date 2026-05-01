# Comptime

`comptime` is Zig's most powerful feature. it allows executing code at compile time.

## Concept
Any code marked with `comptime` is evaluated during compilation. This replaces macros and many uses of generics in other languages.

## Generic Types

In Zig, generic types are just functions that return a `type`.

```zig
fn List(comptime T: type) type {
    return struct {
        items: []T,
        len: usize,

        pub fn init(allocator: Allocator) List(T) {
            // ...
        }
    };
}

const IntList = List(i32);
```

## `comptime` parameters
Functions can have parameters that must be known at compile time.

```zig
fn multiply(comptime T: type, a: T, b: T) T {
    return a * b;
}
```

## `inline` loops and branches
Use `inline for` or `inline if` to unroll loops or branch at compile time.

```zig
const types = [_]type{ i32, f32, bool };
inline for (types) |T| {
    std.debug.print("Type: {}\n", .{T});
}
```

---

**Agent Tip**: `comptime` is how Zig achieves "duck typing" for generic code. If a type has the required fields/methods, it will work. Use `@typeInfo` and `@field` for advanced reflection.
