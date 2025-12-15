const std = @import("std");

const HEAP_SIZE: usize = 1024;
var kernel_heap: [HEAP_SIZE]u8 = undefined;
var heap_used: usize = 0;

fn bumpAlloc(size: usize) ?[]u8 {
    if (heap_used + size > HEAP_SIZE) {
        return null;
    }

    const slice = kernel_heap[heap_used .. heap_used + size];
    heap_used += size;
    return slice;
}

pub fn main() !void {
    const a = bumpAlloc(16) orelse {
        std.debug.print("OUT-OF-MEMORY FOR: a\n", .{});
        return;
    };
    @memset(a, 1);

    const b = bumpAlloc(32) orelse {
        std.debug.print("OUT-OF-MEMORY FOR: b\n", .{});
        return;
    };
    @memset(b, 2);

    const c = bumpAlloc(30) orelse {
        std.debug.print("OUT-OF-MEMORY FOR: b\n", .{});
        return;
    };
    @memset(c, 3);

    std.debug.print("a value: {any}\n", .{a});
    std.debug.print("b value: {any}\n", .{b});
    std.debug.print("c value: {any}\n", .{c});
    std.debug.print("a pointer: {*}\n", .{a.ptr});
    std.debug.print("b pointer: {*}\n", .{b.ptr});
    std.debug.print("c pointer: {*}\n", .{c.ptr});

    const heap_remain = HEAP_SIZE - heap_used;
    std.debug.print("Bytes available: {any}\n", .{heap_remain});
}
