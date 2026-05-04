---
name: zig-libxev
description: Cross-platform event loop library for non-blocking I/O, timers, signals, and async operations in Zig with zero runtime allocations and a C-compatible API. Must use when building async networking, event-driven applications, or integrating Zig event loops across macOS, Linux, and WebAssembly.
---

# libxev

[libxev](https://github.com/mitchellh/libxev) is a cross-platform event loop. It provides a unified abstraction for non-blocking I/O, timers, signals, events, and more.

## Key Features

- Cross-platform: Linux (`io_uring` and `epoll`), macOS (`kqueue`), WebAssembly + WASI (`poll_oneoff`)
- Proactor API: Work is submitted and the caller is notified of completion
- Zero runtime allocations: Predictable performance, well suited for embedded environments
- Timers, TCP, UDP, Files, Processes: High-level platform-agnostic APIs
- Generic Thread Pool (Optional): For background tasks and non-blocking operations
- Low-level and High-Level API: Platform-agnostic high-level API with low-level escape hatch
- Tree Shaking (Zig): Only compiled features are included
- Dependency-free: No dependencies other than built-in OS APIs

## Integration

libxev is written in Zig but exports a C-compatible API, making it usable from any language that can communicate with C APIs.

## Example Usage

Basic example of using libxev to start an event loop and wait for a timer:

```zig
const std = @import("std");
const xev = @import("xev");

pub fn main() !void {
    // Initialize the event loop
    var loop = try xev.Loop.init(.{});
    defer loop.deinit();

    // Create a timer
    var timer = try xev.Timer.init();
    defer timer.deinit();

    // Add a completion that runs after 1 second
    var completion: xev.Completion = undefined;
    timer.run(&loop, &completion, 1000, Timer, null, timerCallback);

    // Run the loop until all events are processed
    try loop.run(.until_done);
}

fn timerCallback(
    userdata: ?*anyopaque,
    l: *xev.Loop,
    c: *xev.Completion,
    r: xev.Timer.RunError!void,
) xev.CallbackAction {
    _ = userdata;
    _ = l;
    _ = c;
    _ = r catch {};
    std.log.info("Timer fired!", .{});
    return .disarm;
}
```

## Agent Tips

- **Callback Action**: Callbacks in libxev must return a `xev.CallbackAction`, such as `.disarm` or `.rearm`. This controls whether the event should fire again.
- **Persistent memory**: `xev.Completion` structures must live for the duration of the async operation. Do not allocate them on a function's stack if that function returns before the event completes.
- **Error handling**: The result `r` passed into callbacks is typically an Error Union. Always unwrap it or handle it (`r catch {}`) before proceeding with success logic.
