# Philosophy & Design Goals

Zig is a general-purpose programming language and toolchain for maintaining robust, optimal, and reusable software.

## The Zen of Zig

* No hidden control flow. No operator overloading, no property getters/setters, no hidden function calls.
* No hidden memory allocations. No `new` keyword, no garbage collection. If it allocates, it takes an `Allocator` parameter.
* No preprocessor, no macros. Use `comptime` instead.
* Errors are values. Handled explicitly, no hidden exceptions.
* Performance and Safety. Manual memory management with safety checks (in Debug/ReleaseSafe modes).

## Core Concepts for Agents

### 1. Robustness
Zig aims to help you write code that is correct. This is achieved through:
- Strict typing.
- Mandatory error handling.
- Compile-time checks.

### 2. Optimality
Zig gives you the tools to write code that is as fast and memory-efficient as C, but with better abstractions.

### 3. Reusability
The build system and package manager are designed to make it easy to use Zig libraries or even C/C++ libraries.

Agent Tip: When writing Zig, always ask: "Where is the memory coming from?" and "How is this error being handled?". Avoid assumptions about hidden behaviors.
