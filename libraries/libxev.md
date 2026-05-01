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
