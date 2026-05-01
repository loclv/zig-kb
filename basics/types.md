# Types & Declarations

Zig is statically typed and provides a rich set of primitives and complex types.

## Primitives

### Integers
- Signed: `i8`, `i16`, `i32`, `i64`, `i128`, `isize`
- Unsigned: `u8`, `u16`, `u32`, `u64`, `u128`, `usize`

### Floats
- `f16`, `f32`, `f64`, `f80`, `f128`

### Boolean
- `bool`: `true` or `false`

### Void
- `void`: Represents the absence of a value.

## Arrays and Slices

- **Array**: Fixed length at compile time. `[5]u32`.
- **Slice**: A pointer and a length. `[]u32` or `[]const u8`.

```zig
const arr = [3]u32{ 1, 2, 3 };
const slice: []const u32 = &arr;
```

## Optional Types

Represent values that might be null.

```zig
var optional_value: ?i32 = null;
optional_value = 5;

if (optional_value) |val| {
    // val is i32
} else {
    // handle null
}
```

## Enums and Unions

```zig
const Color = enum { red, green, blue };

const Payload = union(enum) {
    int: i32,
    float: f32,
};
```

---

**Agent Tip**: Use `usize` for array indexing and pointer arithmetic. Use `[]const u8` for string literals and most string passing.
