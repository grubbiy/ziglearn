const std = @import("std");
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const heap_number = try allocator.create(i32);
    {
        defer allocator.destroy(heap_number);
        heap_number.* = 1001;
        std.debug.print("This heap number is only available in this scope: {}\n", .{heap_number.*});
    }
    // std.debug.print("This heap number would create an error: {}\n", .{heap_number.*});
    // The above line would cause a compile error because heap_number is delete in the scope above
}
