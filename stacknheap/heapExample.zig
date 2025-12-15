const std = @import("std");

fn CreateNumber(allocator: std.mem.Allocator, number: i32) !*i32 {
    const GenNumber = try allocator.create(i32);
    GenNumber.* = number;
    return GenNumber;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    const _Number = try CreateNumber(allocator, 35);
    defer allocator.destroy(_Number);

    std.debug.print("Generated number: {}\n", .{_Number.*});
}
