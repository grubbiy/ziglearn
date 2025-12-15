const std = @import("std");

pub fn main() !void {
    // Create an allocator - this is what manages heap memory
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Allocate space on the heap for a single i32
    const heap_number = try allocator.create(i32);
    defer allocator.destroy(heap_number);

    // Now we can store a value in our heap memory
    heap_number.* = 100;

    std.debug.print("My heap number is: {}\n", .{heap_number.*});

    // YOUR TASK: Create another heap variable called heap_age
    // Store your age in it, print it, and make sure to clean it up!
    // You'll need to use allocator.create() and allocator.destroy()
    // Look at how I did it above for heap_number
    const heap_age = try allocator.create(i32);
    defer allocator.destroy(heap_age);
    heap_age.* = 17;
    std.debug.print("My age is: {}\n", .{heap_age.*});
}
