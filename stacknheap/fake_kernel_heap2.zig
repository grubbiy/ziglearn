const std = @import("std");

const HEAP_SIZE: usize = 1028;
var kernel_heap: [HEAP_SIZE]u8 = undefined;
var heap_used: usize = 0;

fn alloc(size: usize) ?[]u8 {
    if (heap_used + size > HEAP_SIZE) {
        return null;
    }

    const slice = kernel_heap[heap_used .. heap_used + size];
    heap_used += size;
    return slice;
}

pub fn main() !void {
    const a = alloc(20) orelse {
        std.debug.print("OUT-OF-MEMORY FOR: a\n", .{});
        return;
    };
    @memset(a, 1);

    std.debug.print("a value: {any}\n", .{a});
    std.debug.print("a pointer: {*}\n", .{a.ptr});
}
