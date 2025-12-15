const std = @import("std");

pub fn main() void {
    const a: i32 = 100;
    const b: i32 = 101;
    const c: i32 = 100;
    const d: i32 = 101;
    const e: i32 = 103;
    const f: i32 = 103;

    std.debug.print("Memory location of a: {*}\n", .{&a});
    std.debug.print("Memory location of b: {*}\n", .{&b});
    std.debug.print("Memory location of c: {*}\n", .{&c});
    std.debug.print("Memory location of d: {*}\n", .{&d});
    std.debug.print("Memory location of e: {*}\n", .{&e});
    std.debug.print("Memory location of f: {*}\n", .{&f});
}
