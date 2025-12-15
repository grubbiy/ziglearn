const std = @import("std");

fn bigStack() [10_000_000]u8 {
    // We can put 10-million on stack, but not 100 million like the heap
    const too_big: [10_000_000]u8 = undefined;
    return too_big;
}

fn bigHeap(allocator: std.mem.Allocator) ![]u8 {
    // Put a HUGE 100-million-byte number on the heap
    const big = try allocator.alloc(u8, 100_000_000);
    return big;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    const hugeHeap = try bigHeap(allocator);
    const hugeStack = bigStack();
    defer allocator.free(hugeHeap);

    std.debug.print("Heap handled a huge number! Size: {}\n", .{hugeHeap.len});
    std.debug.print("Stack handled a decent number! Size: {}\n", .{hugeStack.len});
}