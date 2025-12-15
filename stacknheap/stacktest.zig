const std = @import("std");
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    const heap_number = try allocator.create(i32);
    defer allocator.destroy(heap_number);
    heap_number.* = blk: {
        break :blk 384 + 394;
    };
    std.debug.print("Scope heap number is: {}\n", .{heap_number.*});
    std.debug.print("Scope heap number address: {*}\n", .{heap_number});
}
