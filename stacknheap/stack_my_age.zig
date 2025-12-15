const std = @import("std");
pub fn main() !void {
    // Stack variable - this gets cleaned up automatically
    const stack_number: i32 = 42;

    // Print the stack number
    std.debug.print("My stack number is: {}\n", .{stack_number});

    const my_age: i32 = 17;
    std.debug.print("My age is: {}\n", .{my_age});
}
