---
name: zig-kb-overview
description: Master index for the Zig Knowledge Base. Lists all topics including philosophy, syntax, memory, errors, comptime, build system, stdlib patterns, and migration guides.
---

# Zig Knowledge Base (zig-kb)

A structured, AI-optimized knowledge base for the Zig programming language. Designed to help AI agents understand Zig's unique features, idioms, and best practices.

## Table of Contents

- [Philosophy & Design Goals](philosophy.md) - The "Zen of Zig" and core concepts.
- [Basics](basics/)
    - [Syntax Overview](basics/syntax.md)
    - [Types & Declarations](basics/types.md)
    - [Control Flow](basics/control_flow.md)
- [Memory Management](memory/)
    - [Allocators](memory/allocators.md)
    - [Pointers & Slices](memory/pointers.md)
    - [Resource Management (defer/errdefer)](memory/resource_management.md)
- [Error Handling](errors/error_handling.md) - Error sets, try, catch, and payloads.
- [Comptime](comptime/comptime_basics.md) - Powerful metaprogramming and compile-time execution.
- [Standard Library Patterns](stdlib/common_patterns.md) - Common tasks with `std`.
- [Build System](build/build_system.md) - Using `build.zig`.
- [Tools](tools/)
    - [ziglint](tools/ziglint.md) - Opinionated linting for Zig.
    - [zigdoc](tools/zigdoc.md) - CLI documentation browser for std and imported modules.
- [Migrations](migrations/)
    - [Migrating to 0.15](migrations/0.15.md) - I/O overhaul, ArrayList changes, `usingnamespace` removal.
    - [Migrating to 0.16](migrations/0.16.md) - I/O as interface, `@Type` builtins, packed type restrictions.

## How to use this KB
Each document follows a consistent structure:
1. Concept: High-level explanation.
2. Syntax: Formal representation.
3. Examples: Clear, idiomatic code snippets.
4. Agent Tips: Specific advice for LLMs writing Zig code.
