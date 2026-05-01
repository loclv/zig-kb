# Allocators

In Zig, memory allocation is explicit. Functions that need to allocate memory usually take an `Allocator` as an argument.

## Common Allocators

### `std.heap.page_allocator`
Allocates memory directly from the OS. Efficient for large allocations, but slow for small ones.

### `std.heap.GeneralPurposeAllocator` (GPA)
A good general-purpose allocator with safety features for debugging leaks.

### `std.heap.ArenaAllocator`
Wraps another allocator and allows freeing all allocated memory at once.

### `std.heap.FixedBufferAllocator`
Allocates memory from a fixed-size buffer. No heap allocation.

## Usage Example

```zig
const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const list = try allocator.alloc(u8, 100);
    defer allocator.free(list);
}
```

## When to use what?
- **Testing**: Use `std.testing.allocator`. It detects leaks automatically.
- **CLI Tools**: `ArenaAllocator` is often great for simplicity.
- **Embedded**: `FixedBufferAllocator` or custom static allocators.

---

**Agent Tip**: If you are writing a library function that allocates, **always** accept an `Allocator`. Never use `page_allocator` inside a reusable library.
