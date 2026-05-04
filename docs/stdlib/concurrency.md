---
name: zig-concurrency-threads
description: Zig concurrency using std.Thread, Mutexes, and atomic operations. Must use when writing multi-threaded Zig code or managing concurrent state.
---

# Concurrency and Threads

Zig does not have a built-in async/await runtime or a heavy standard library threading model. Instead, it provides low-level primitives through `std.Thread` and `std.Thread.Mutex`.

## Creating Threads

Spawning a thread in Zig requires a function and its arguments. The `std.Thread.spawn` function takes a configuration (often empty `{}`), the function to execute, and a tuple of arguments.

```zig
const std = @import("std");

fn worker(id: u32) void {
    std.log.info("Worker {d} started", .{id});
    std.time.sleep(100 * std.time.ns_per_ms);
}

pub fn main() !void {
    const t1 = try std.Thread.spawn(.{}, worker, .{1});
    const t2 = try std.Thread.spawn(.{}, worker, .{2});

    t1.join();
    t2.join();
}
```

## Mutexes

When sharing data between threads, use `std.Thread.Mutex`.

```zig
const std = @import("std");

const SharedState = struct {
    mutex: std.Thread.Mutex = .{},
    counter: u32 = 0,
};

fn incrementer(state: *SharedState, amount: u32) void {
    state.mutex.lock();
    defer state.mutex.unlock();
    state.counter += amount;
}
```

## Agent Tips

- **No default async**: Zig removed its experimental async/await support in 0.11.0. Do not write `async` or `await` keywords. Use OS threads via `std.Thread` or event loops like libxev.
- **Pass by pointer**: When sharing state with a thread, ensure you pass a pointer to the state, not a copy.
- **Join your threads**: Always join or detach threads to prevent resource leaks.
