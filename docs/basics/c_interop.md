---
name: zig-c-interop
description: Zig C interoperability using @cImport, C headers, linking, and translate-c. Must use when interfacing with C libraries from Zig.
---

# C Interoperability

Zig is designed to be a drop-in replacement for C compilers, and it has first-class support for interoperating with C code. You can include C headers directly in your Zig code and call C functions seamlessly.

## @cImport and @cInclude

To use a C library, import its header file using `@cImport` and `@cInclude`.

```zig
const c = @cImport({
    @cInclude("stdio.h");
    @cInclude("sqlite3.h");
});

pub fn main() void {
    _ = c.printf("Hello from C printf!\n");
}
```

## Linking C Libraries

When you include a C header, you must also link the corresponding C library and libc during the build process.

In `build.zig`:
```zig
exe.linkLibC();
exe.linkSystemLibrary("sqlite3");
```

Or via the CLI:
```bash
zig build-exe main.zig -lc -lsqlite3
```

## Translating C Types

Zig automatically translates C types to Zig types. For example:
- `int` becomes `c_int`
- `char *` becomes `[*]c_u8` or `[*:0]u8`

Be careful when passing Zig slices or strings to C functions. C expects null-terminated strings (`[*:0]const u8`), whereas Zig slices (`[]const u8`) are bounded and not guaranteed to be null-terminated.

## Agent Tips

- **Use c_int and c_uint**: When matching C signatures, use `c_int`, `c_uint`, `c_long`, etc., rather than `i32` or `u32`, as C sizes vary by platform.
- **Null termination**: Always ensure strings passed to C are null-terminated. You can use Zig's `[:0]` syntax to assert or create null-terminated slices.
- **Pointer types**: Zig distinguishes between single-item pointers (`*T`), many-item pointers (`[*]T`), and C-pointers (`[*c]T`). C interop heavily uses C-pointers, which can be implicitly coerced.
