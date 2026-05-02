---
name: zig-std-module
description: The Zig standard library entry point (`std.zig`). Documents re-exported types, module imports, and the compile-time `Options` struct. Must use when navigating or understanding std library structure.
---

# The `std.zig` Entry Point

File: `lib/std/std.zig` — this is what you get when you write `const std = @import("std");`.

## Re-exported Convenience Types

These are commonly-used types lifted directly from submodules so you can write `std.ArrayList(T)` instead of `std.array_list.Aligned(T, null)`.
| Type | Source Module | Notes |
|---|---|---|
| `std.ArrayList(T)` | `array_list.Aligned(T, null)` | Growable contiguous list. |
| `std.ArrayListAligned` | `array_list.Aligned` | Deprecated. |
| `std.ArrayListUnmanaged` | alias of `ArrayList` | Deprecated. |
| `std.AutoHashMap` | `hash_map.AutoHashMap` | Hash map using `std.hash.AutoContext`. |
| `std.AutoHashMapUnmanaged` | `hash_map.AutoHashMapUnmanaged` | Same, no allocator field. |
| `std.StringHashMap` | `hash_map.StringHashMap` | Keys are `[]const u8`. |
| `std.StringHashMapUnmanaged` | `hash_map.StringHashMapUnmanaged` | Same, no allocator field. |
| `std.HashMap` | `hash_map.HashMap` | Generic hash map. |
| `std.HashMapUnmanaged` | `hash_map.HashMapUnmanaged` | Same, no allocator field. |
| `std.StaticStringMap` | `static_string_map.StaticStringMap` | Compile-time string map. |
| `std.StaticStringMapWithEql` | `static_string_map.StaticStringMapWithEql` | With custom equality. |
| `std.BufMap` | `buf_map.BufMap` | String-to-string map. |
| `std.BufSet` | `buf_set.BufSet` | String hash set. |
| `std.PriorityQueue` | `priority_queue.PriorityQueue` | Binary heap queue. |
| `std.PriorityDequeue` | `priority_dequeue.PriorityDequeue` | Double-ended priority queue. |
| `std.Deque` | `deque.Deque` | Double-ended queue. |
| `std.MultiArrayList` | `multi_array_list.MultiArrayList` | Struct-of-arrays storage. |
| `std.SinglyLinkedList` | `SinglyLinkedList.zig` | Basic linked list. |
| `std.DoublyLinkedList` | `DoublyLinkedList.zig` | Doubly linked list. |
| `std.DynamicBitSet` | `bit_set.DynamicBitSet` | Runtime-sized bit set. |
| `std.DynamicBitSetUnmanaged` | `bit_set.DynamicBitSetUnmanaged` | Same, no allocator field. |
| `std.StaticBitSet` | `bit_set.StaticBitSet` | Compile-time sized bit set. |
| `std.BitStack` | `BitStack.zig` | Stack of bits. |
| `std.EnumArray` | `enums.EnumArray` | Array indexed by enum. |
| `std.EnumMap` | `enums.EnumMap` | Map keyed by enum. |
| `std.EnumSet` | `enums.EnumSet` | Set backed by enum. |
| `std.Random` | `Random.zig` | Random number generator interface. |
| `std.SemanticVersion` | `SemanticVersion.zig` | Semver parsing/comparison. |
| `std.Thread` | `Thread.zig` | Thread spawning and synchronization. |
| `std.Progress` | `Progress.zig` | Terminal progress bars. |
| `std.Build` | `Build.zig` | The build system API (`build.zig`). |
| `std.Io` | `Io.zig` | Async I/O abstraction. |
| `std.Tz` | `tz.Tz` | Timezone handling. |
| `std.Uri` | `Uri.zig` | URI parsing. |
| `std.Target` | `Target.zig` | Cross-compilation target info. |
| `std.Treap` | `treap.Treap` | Self-balancing BST. |
| `std.DynLib` | `dynamic_library.zig` | Dynamic library loading. |

### Deprecated Aliases

```zig
pub const ArrayHashMapUnmanaged = array_hash_map.Custom;
pub const AutoArrayHashMapUnmanaged = array_hash_map.Auto;
pub const StringArrayHashMapUnmanaged = array_hash_map.String;
```

Prefer the `array_hash_map` namespace directly.

## Submodules

Everything else is reached through namespaces. Key ones:

```zig
std.array_list // ArrayList internals
std.array_hash_map
std.atomic
std.base64
std.bit_set
std.builtin // @import("builtin") re-export
std.compress
std.crypto
std.debug
std.enums
std.fmt
std.fs
std.hash
std.hash_map
std.heap
std.http
std.json
std.log
std.math
std.mem
std.meta
std.os
std.posix
std.process
std.sort
std.testing
std.time
std.unicode
std.wasm
std.zip
std.zon
```

## Compile-Time Options (`std.options`)

The root source file can declare `pub const std_options: std.Options = .{ ... };` to override standard library defaults.
Key fields:

```zig
pub const Options = struct {
    enable_segfault_handler: bool = true,
    signal_stack_size: ?u64 = 1 << 18,
    log_level: log.Level = .warn,
    log_scope_levels: []const log.ScopeLevel = &.{},
    logFn: fn (...) void = log.defaultLog,
    page_size_min: ?usize = null,
    page_size_max: ?usize = null,
    fmt_max_depth: usize = 3,
    http_disable_tls: bool = false,
    http_enable_ssl_key_log_file: bool = builtin.mode == .Debug,
    side_channels_mitigations: crypto.SideChannelsMitigations = .full,
    allow_stack_tracing: bool = !builtin.strip_debug_info,
    networking: bool = true,
    unexpected_error_tracing: bool = ..., // Debug + LLVM/x86_64 only
    // ...plus Io, FilePermissions, cwd overrides
};
```

Usage in `root.zig` or `main.zig`:

```zig
pub const std_options: std.Options = .{
    .log_level = .info,
    .enable_segfault_handler = false,
};
```

## Startup (`start.zig`)

At the bottom:

```zig
comptime {
    _ = start;
}
```

This forces `start.zig` to be analyzed, which exports the executable entry point (`_start` / `WinMain` / etc.) and calls `main`.

## Tests

```zig
test {
    testing.refAllDecls(@This());
}
```

This references all public declarations so the test runner discovers tests across all submodules.
