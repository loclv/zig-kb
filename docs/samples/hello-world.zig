// Minimal hello world application. Must use when verifying basic compilation and standard output in Zig.
const std = @import("std");
const Io = std.Io;

pub fn main(init: std.process.Init) !void {
    try Io.File.stdout().writeStreamingAll(init.io, "hello world!\n");
}
