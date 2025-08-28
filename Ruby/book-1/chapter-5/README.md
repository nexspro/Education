# Chapter 5: Methods, Parameters & Blocks

## What I did
- Redefined methods inside a class to see overwrite behavior.
- Wrote one-line method definitions and empty methods returning `nil`.
- Practiced predicate methods (`even?`, `instance_of?`) for type and numeric checks.
- Compared non-destructive (`chop`) vs destructive (`chop!`) string methods.
- Built a `Matrix` class with operator overloading (`+`) and custom `to_s`.
- Defined **class methods** and **singleton methods** on specific instances.
- Used positional parameters, return values, defaults, and computed defaults.
- Captured extra arguments with splat (`*args`) and forwarded/ignored them in subclasses.
- Practiced splat forwarding between methods and destructuring with `first, *rest, last`.
- Worked with keyword arguments (required, defaults, `**rest`, forwarding).
- Implemented APIs using the **option hash pattern** for flexibility.
- Passed behavior into methods using blocks and `yield`.
- Used argument forwarding (`...`) to preserve full signatures with `*args, **kwargs, &block`.
- Built a callback system (`dowload_mp3`) with block progress reporting.
- Called standard library features: `File.size`, `Math.sin`.
- Implemented a **Template Method pattern** with `InvoiceWriter` (public vs private helpers).
- Wrote manual accessors, used `self=` in writers, and chained with keywords.
- Practiced return values, case statements, multiple return values, and destructuring.
- Expanded arrays/ranges with splat and hashes with double-splat (`**data`).
- Used concise block syntax vs `Symbol#to_proc` (`map(&:upcase)`).
- Demonstrated functional style with three approaches to dynamic operator selection (if/else, lambda, bound `Method`).

## Key Concepts
- **Methods**: redefinition, one-line syntax, empty return, operator overloading.
- **Predicates & Types**: numeric checks, type introspection.
- **Strings**: destructive vs non-destructive behavior.
- **Parameters**: positional, defaults, splat (`*args`), keyword (`**kwargs`), forwarding (`...`).
- **Inheritance**: `super`, splat forwarding/ignoring.
- **Blocks & Yield**: passing code, callbacks, progress updates.
- **Argument Handling**: splat expansion, destructuring, keyword forwarding.
- **Patterns**: option hash APIs, Template Method design pattern.
- **Standard Library**: File and Math usage.
- **Functional Style**: lambdas, procs, bound methods for dynamic behavior.