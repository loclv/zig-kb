---
name: zig-build-zon-dependencies
description: Managing Zig package dependencies using build.zig.zon, url, and hash fields. Must use when adding third-party libraries or modules to a Zig project.
---

# `build.zig.zon` Dependencies

Zig's package manager relies on `build.zig.zon` (Zig Object Notation) to define a project's metadata and dependencies. It allows fetching external Zig projects or C libraries directly during the build phase.

## The build.zig.zon File

A typical `build.zig.zon` file looks like this:

```zig
.{
    .name = "my_project",
    .version = "0.1.0",
    .paths = .{
        "src",
        "build.zig",
        "build.zig.zon",
    },
    .dependencies = .{
        .zap = .{
            .url = "https://github.com/zigzap/zap/archive/refs/tags/v0.8.0.tar.gz",
            .hash = "1220...", // The multihash of the archive
        },
    },
}
```

## Adding a Dependency

To add a dependency, you need its URL. You can use the `zig fetch` command to download it and automatically update your `build.zig.zon` with the correct hash:

```bash
zig fetch --save https://github.com/zigzap/zap/archive/refs/tags/v0.8.0.tar.gz
```

Alternatively, you can manually add the URL to `build.zig.zon`, run `zig build`, and the compiler will print the expected hash, which you can then paste into the file.

## Using Dependencies in `build.zig`

Once defined in `build.zig.zon`, the dependency must be wired into your build script:

```zig
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "my_project",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // 1. Get the dependency from build.zig.zon
    const zap_dep = b.dependency("zap", .{
        .target = target,
        .optimize = optimize,
    });

    // 2. Add the module exported by the dependency
    exe.root_module.addImport("zap", zap_dep.module("zap"));

    b.installArtifact(exe);
}
```

## Agent Tips

- **No central registry**: Zig does not have a central package registry (like npm or crates.io). Dependencies are resolved via URLs (HTTP or Git) pointing to archives or repositories.
- **b.dependency**: The string passed to `b.dependency()` must exactly match the key used in the `.dependencies` map in `build.zig.zon`.
- **b.path()**: Use `b.path()` for paths starting in Zig 0.12+ instead of `.path = "..."` when setting root source files.
