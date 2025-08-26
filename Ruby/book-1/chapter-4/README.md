# Chapter 3: Arrays, Hashes, Enumerables & Lazy Iterators

## What I did

- Built a hands-on exercise file that walks through core Ruby features end-to-end:

- Arrays: creation, indexing (including negative), range/slice reads, and in-place assignments (single element & slices).

- Shorthand literals: %w (strings) and %i (symbols).

- Data structures by behavior: stack (LIFO with push/pop) vs queue (FIFO with push/shift).

- Convenient accessors: first, last (element vs. n-element slice forms).

- Hash basics: lookup, insertion, overwrite, mixed key types, and symbol-key syntax (=> vs key:).

- Keyword capture: hash shorthand { first_name:, last_name: }.

- Nested data traversal: safe reads with Hash#dig.

- Text processing: tokenization helper (extract_words / tokens_from), frequency counting, and a small   “tokenize → count → sort → top-N” pipeline.

- Tests: Minitest specs for tokenization and counting.

- Enumerable patterns: each, running totals, sum of squares.

- A tiny class (Polygon) plus exception handling and scoping (shadowing, block-local, numbered params).

- Blocks → Procs/lambdas: capturing behavior, arity differences, closures (stateful and stateless), custom control flow (branch_if, loop_while).

- File I/O: File.open iteration, indexed reads, and two helpers that guarantee closure (open_and_process, my_open).

- Reductions: reduce/inject, symbol shorthands, sum, Cartesian product.

- Enumerators: external iteration with to_enum, reverse_each, next, enum_for(:each_slice, 3).

- Building streams: manual Enumerator.new (triangular numbers) and Enumerator.produce.

- Lazy pipelines: infinite streams with .lazy, predicate filtering (multiples/palindromes), and reusable lambda predicates.

## Key Concepts

- Arrays: heterogeneous values; out-of-bounds reads return nil; negative indices count from the tail; slice semantics with [start, length] and ranges (.. inclusive, ... exclusive); sparse writes fill gaps with nil.

- Hashes: ordered since Ruby 1.9; keys can be any object (strings, integers, symbols); prefer consistent key types in real projects; choose => when the key isn’t a simple symbol.

- Text pipeline: normalize (downcase) → tokenize (regex) → count (Hash.new(0) or tally) → sort → report top-N.

- Enumerables: iterate without mutation; accumulate external state for running totals; understand reduce seeds vs. no-seed behavior.

- Blocks / Procs / Lambdas:

- & converts block ↔ Proc;

- lambdas enforce arity and return exits the lambda only;

- procs are lenient on arity;

- closures capture surrounding variables by reference (state can evolve).

- Control Flow as Data: pass callables (-> { ... }) into helpers like branch_if / loop_while.

- File I/O: block form of File.open auto-closes; ensure guarantees closure even on exceptions; gets returns nil at EOF.

- Enumerators: to_enum/enum_for produce external iterators; next raises StopIteration at end; .lazy defers computation until a terminal op (first, take, etc.).

- Testing: Minitest auto-runs when require "minitest/autorun" is loaded—great for quick verification.