# Resource Management (defer & errdefer)

Zig uses `defer` and `errdefer` to ensure resources (memory, file handles, etc.) are properly cleaned up.

## `defer`
Executes a statement when the current block is exited, regardless of how it's exited (return, end of block).

```zig
const file = try std.fs.cwd().openFile("data.txt", .{});
defer file.close(); // Guaranteed to run
```

## `errdefer`
Executes a statement **only** if the function returns an error. This is crucial for cleaning up partially allocated state during an error.

```zig
pub fn createList(allocator: Allocator) ![]u8 {
    const list = try allocator.alloc(u8, 10);
    errdefer allocator.free(list); // Free only if subsequent steps fail

    try fillList(list); // If this fails, errdefer runs
    return list;
}
```

## Order of Execution
`defer` statements are executed in **reverse** order of their declaration (LIFO).

---

**Agent Tip**: Use `defer` for cleanup that must always happen. Use `errdefer` inside factory functions or multi-step initializations to prevent leaks on partial failures.
