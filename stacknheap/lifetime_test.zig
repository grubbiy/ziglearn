const std = @import("std");
fn makeAgeHeap(allocator: std.mem.Allocator, value: i32) !*i32 {
    const age = try allocator.create(i32);
    age.* = value;
    return age;
}
fn makeAgeStack(value: i32) i32 {
    const number: i32 = value;
    return number;
}
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){}; // Create allocator object (memory manager),
    // var because allocator
    // mutates internal state as we allocate/free

    defer _ = gpa.deinit(); // when main ends, deinit allocator and check for leaks (we ignore the bool result)
    // in serious code, we can check it:
    // if (!ok) std.debug.print("leaks detected\n", .{});

    const allocator = gpa.allocator(); // We create an object allocator

    const ageHeap = try makeAgeHeap(allocator, 17); // We make a var that is either a valid pointer to an address, or null (nothing)
    allocator.destroy(ageHeap.?); // free the heap memory that this pointer points to.
    ageHeap = null; // Why is it so powerfull to set as null, here is why:
    // We have already freed the heap memory that the pointer points to,
    // so now we have an invalid address at that pointer.
    // We may accidentally use it again and use an invalid address,
    // BUT by hardcoding it to null means that if we want to use it again,
    // we have to deal with the "maybe null" case.

    const ageStack = makeAgeStack(17);

    std.debug.print("Age stack value: {}\n", .{ageStack});
    std.debug.print("Age stack address: {*}\n", .{&ageStack});
    // std.debug.print("Age heap value: {}\n", .{ageHeap.*});
    // std.debug.print("Age heap address: {*}\n", .{ageHeap});

    if (ageHeap) |ptr| { // If ageHeap is a valid pointer address. (check if value is true or false)
        std.debug.print("Age heap value: {}\n", .{ptr.*});
    } else { // If it is not a valid pointer address.
        std.debug.print("Age heap has been freed\n", .{});
    }
}
