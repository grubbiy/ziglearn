# Zig Types (Quick Notes)

## Integers

**Syntax**
- Unsigned: `uN` (e.g. `u8`, `u16`, `u32`, `u64`, `u128`)
- Signed: `iN` (e.g. `i8`, `i16`, `i32`, `i64`, `i128`)
- Pointer-sized: `usize`, `isize`
- Compile-time-only: `comptime_int`

**Size**
- `uN` / `iN`: `N` bits → `ceil(N/8)` bytes (examples: `u8`=1, `u16`=2, `u32`=4, `u64`=8, `u128`=16)
- `usize` / `isize`: pointer size (usually 8 bytes on 64-bit, 4 bytes on 32-bit)
- `comptime_int`: no runtime size (compile-time only)

## Floats

**Syntax**
- `f16` (2 bytes), `f32` (4), `f64` (8), `f80` (10), `f128` (16)
- `comptime_float`: compile-time only (no runtime size)

## Booleans / “no value”

**Syntax + size**
- `bool`: typically 1 byte
- `void`: 0 bytes (no value)
- `noreturn`: no value (functions that never return)

## Pointers and pointer-like

**Syntax**
- Single-item pointer: `*T`
- Many-item pointer: `[*]T`
- Optional pointer: `?*T`
- Slice (pointer + length): `[]T`
- Sentinel-terminated: `[:0]u8`, `[*:0]u8`, etc.

**Size**
- `*T`, `[*]T`: pointer size (usually 8 or 4)
- `[]T`: pointer + `usize` length (usually 16 bytes on 64-bit, 8 on 32-bit)
- `?*T`: usually same as pointer size (uses null as “none”)
- Sentinel forms: same size as their underlying pointer/slice form

## Arrays and vectors

**Syntax + size**
- Array: `[N]T` → exactly `N * @sizeOf(T)` bytes
- Vector (SIMD): `@Vector(N, T)` → `N * @sizeOf(T)` bytes

## Struct / enum / union / opaque

**Syntax**
- `struct { ... }`
- `enum { ... }` or `enum(u8) { ... }` (you can choose integer backing type)
- `union { ... }` / `union(enum) { ... }`
- `opaque {}`

**Size**
- `struct`: sum of fields + padding/alignment (target/layout dependent)
- `enum`: size of its integer tag (default is compiler-chosen; explicit like `enum(u8)` forces 1 byte)
- `union`: size of largest field (+ tag if it’s a tagged union)
- `opaque`: size unknown/incomplete (you can only use pointers to it)

## Optionals and error handling

**Syntax**
- Optional: `?T`
- Error set: `error{A, B}` (and `anyerror` in older Zig; modern Zig prefers explicit sets)
- Function type: `fn (args) return_type`
- Function pointer: `*const fn (args) return_type` → pointer size

## `std.debug.print` format quick guide

There isn’t a separate format like `{u8}` / `{struct}` for each Zig type; you pick a formatter based on how you want the value printed.

- Safe default for most things: `{any}`
- Integers (`u8`, `i32`, `usize`, …): `{d}` (decimal), `{x}` (hex), `{b}` (binary), `{o}` (octal)
- Floats (`f32`, `f64`, …): `{}` (default), `{e}` (scientific)
- Bool (`bool`): `{}`
- Strings (`[]const u8`, `[:0]const u8`): `{s}`
- Pointers (`*T`, `[*]T`): `{*}` (prints the address), or use `0x{x}` with `@intFromPtr(ptr)`
- Slices (`[]T`): `{any}` (prints `{ ptr, len }`), or `{s}` if it’s `[]const u8`
- Arrays (`[N]T`): `{any}`, or `{s}` with `arr[0..]` for `[N]u8` text
- Struct/enum/union: `{any}`

Examples:
```zig
std.debug.print("{d}\n", .{some_i32});
std.debug.print("{x}\n", .{some_u64});
std.debug.print("{s}\n", .{some_bytes});
std.debug.print("{*}\n", .{some_ptr});
std.debug.print("{any}\n", .{some_struct_or_slice});
```
