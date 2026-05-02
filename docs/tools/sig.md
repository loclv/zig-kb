---
name: sig-strict-zig
description: Capacity-first memory model layer on top of the Zig compiler. Drop-in replacement enforcing caller-owned buffers, bounded containers, and visible allocations via .sig strict-mode files.
---

# Sig — Strict Zig

<https://github.com/SB0LTD/sig>
Sig is a capacity-first memory model layer on top of the Zig compiler. Every buffer is caller-owned, every container is bounded, and every allocation is visible. It acts as a drop-in replacement for `zig`.

## Core Idea

Instead of implicit heap allocations, Sig requires callers to provide buffers and uses comptime-known capacities.

```zig
// Standard Zig — allocator is runtime parameter, capacity implicit
var list = std.ArrayList(u8).init(allocator);
try list.appendSlice(data); // might realloc 1x, 2x, 4x…

// Sig — you provide the buffer, capacity is the type
var buf: [4096]u8 = undefined;
const result = try sig.fmt.formatInto(&buf, "{s}: {d}", .{ name, count });
```

## Bounded Containers

Capacity is comptime-known. Operations return `CapacityExceeded` instead of reallocating.

```zig
var vec = sig.containers.BoundedVec(u32, 1024){};
try vec.push(10);
try vec.push(20); // returns CapacityExceeded if full
```

## Strict Mode (.sig files)

The `.sig` file extension enables strict mode. Same syntax and parser as `.zig`, but allocator usage is a compile error.

```text
src/core.sig:42:5: error: direct allocation in 'init' (.sig file: strict mode enforced)
```

| File | `allocator.alloc(...)` | Behavior |
|---|---|---|
| `foo.zig` | Allowed | Warning (or error with `--sig-mode=strict`) |
| `foo.sig` | Not allowed | Compile error, always |

`.sig` and `.zig` files interoperate via `@import`. You can adopt strict mode one file at a time.

## Error Model

Four explicit errors replace silent reallocation:
| Error | Meaning |
|---|---|
| `BufferTooSmall` | Output exceeds the caller-provided buffer |
| `CapacityExceeded` | Bounded container is full |
| `DepthExceeded` | Recursive operation hit depth limit |
| `QuotaExceeded` | Resource usage limit reached |

## Memory Patterns

| Pattern | In `.sig` files |
|---|---|
| `var buf: [1024]u8 = undefined;` | ✅ |
| `fn read(buf: []u8) ![]u8` | ✅ |
| `BoundedVec(u8, 256)` | ✅ |
| `FixedPool(Node, 64)` | ✅ |
| `allocator.alloc(u8, n)` | ❌ compile error |
| `fn init(alloc: Allocator)` | ❌ compile error |
| `list.ensureTotalCapacity(n)` | ❌ compile error |

In `.zig` files, the ❌ patterns compile normally with optional warnings.

## Installation

Download a binary from [releases](https://github.com/SB0LTD/sig/releases), or build from source:

```bash
git clone https://github.com/SB0LTD/sig.git
cd sig && sig build
```

```bash
$ sig version
sig 0.1.2 (zig 0.17.0-dev)
```

## The Spoon Model

Sig is not a traditional fork; it is a Spoon — a close derivative that stays continuously synchronized with upstream Zig. Every upstream commit flows into Sig automatically via `sig-sync` with near-zero divergence.
|  | Traditional Fork | Spoon (Sig) |
|---|---|---|
| Upstream tracking | Manual, periodic | Continuous, automatic |
| Divergence over time | Grows unbounded | Near zero |
| Merge conflicts | Accumulate silently | Resolved immediately |
| Upstream compatibility | Degrades | Always maintained |

Sig tracks upstream at [codeberg.org/ziglang/zig](https://codeberg.org/ziglang/zig) with sub-minute sync latency.
