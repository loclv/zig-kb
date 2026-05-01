# Control Flow

Zig provides standard control flow structures with some unique safety features.

## If Statements

`if` can be used as a statement or an expression.

```zig
const x: i32 = if (a > b) a else b;

if (condition) {
    // ...
} else {
    // ...
}
```

## While Loops

```zig
var i: usize = 0;
while (i < 10) : (i += 1) {
    if (i == 5) continue;
    // ...
}
```
The `: (i += 1)` part is the **continue expression**, which is guaranteed to run even if `continue` is called.

## For Loops

For loops iterate over slices and arrays.

```zig
const items = [_]i32{ 1, 2, 3 };
for (items, 0..) |item, index| {
    std.debug.print("{d}: {d}\n", .{index, item});
}
```
The `0..` syntax provides an index.

## Switch

Switches are exhaustive and can match ranges.

```zig
switch (value) {
    0...10 => { /* range 0 to 10 inclusive */ },
    11, 12 => { /* multiple values */ },
    else => { /* default case */ },
}
```

---

**Agent Tip**: Remember that `if` and `while` expect a `bool`, not an integer. For optional types, use the capture syntax: `if (optional) |val|`.
