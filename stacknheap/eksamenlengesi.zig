const std = @import("std");

fn heapArray(allocator: std.mem.Allocator, size: usize) ![]u8 {
    const array = try allocator.alloc(u8, size);
    @memset(array, 1);
    return array;
}

fn massiveInteger(allocator: std.mem.Allocator) !*i128 {
    const massive = try allocator.create(i128);
    massive.* = 100000;
    return massive;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();
    const myarray = try heapArray(allocator, 60);
    defer allocator.free(myarray);

    std.debug.print("Array value: {any}\n", .{myarray});
    std.debug.print("Array pointer: {*}\n", .{myarray.ptr});

    for (0..myarray.len) |i| {
        myarray[i] = @intCast(i + 1);
    }
    std.debug.print("Etter: {any}\n", .{myarray});

    const massiveInt = try massiveInteger(allocator);
    defer allocator.destroy(massiveInt);
    std.debug.print("Massive int value: {d}\n", .{massiveInt.*});
    std.debug.print("Massive int pointer: {*}\n", .{massiveInt});
}
