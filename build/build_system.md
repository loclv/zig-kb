# Build System

Zig features a powerful build system written in Zig itself. The configuration file is always `build.zig`.

## Basic `build.zig` Structure

```zig
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "my-app",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(exe);
}
```

## Common Commands
- `zig build`: Build the project.
- `zig build run`: Build and run the executable.
- `zig build test`: Run the tests.

## Adding Dependencies
Dependencies are managed via `build.zig.zon` and then referenced in `build.zig`.

---

**Agent Tip**: The build system allows for complex build-time logic, such as generating source files or running custom commands. Use `b.addModule` to create reusable internal modules.
