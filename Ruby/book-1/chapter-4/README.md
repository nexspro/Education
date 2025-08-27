# Chapter 4: Collections, Iterators & Enumerators

## What I did
- Created and manipulated arrays (indexing, slices, ranges, negative indices).
- Mutated arrays with element assignment and slice assignment (replace, insert, delete).
- Used `%w` and `%i` literals for shorthand arrays of strings and symbols.
- Demonstrated stack (`push`/`pop`) and queue (`push`/`shift`) behavior with arrays.
- Explored `first` / `last` accessors with and without arguments.
- Built and queried hashes with string, symbol, and mixed keys.
- Used Ruby 3.1+ hash shorthand (`{ var: }`) to capture locals.
- Navigated nested hashes/arrays with safe access via `dig`.
- Implemented text tokenization with regex and built frequency counters.
- Built a text-processing pipeline: tokenize → count → sort → top N.
- Wrote unit tests with **Minitest** for tokenization and counting.
- Practiced with **Enumerable** basics: `each`, running totals, sum of squares.
- Defined custom classes and handled exceptions with `begin`/`rescue`.
- Demonstrated variable shadowing and block-local variables.
- Wrote custom iterators using `yield`, extended Array with new methods.
- Read files safely using `File.open` with blocks, `ensure`, and custom helpers.
- Explored **reduce/inject** for sum and product with and without initial values.
- Built and consumed enumerators via `to_enum`, `enum_for`, and `next`.
- Implemented custom infinite enumerators with `Enumerator.new` and `Enumerator.produce`.
- Used **lazy enumerators** with `.lazy` + `.select` pipelines for efficient infinite streams.
- Composed filters with predicates, lambdas, and closures.

## Key Concepts
- **Arrays**: indexing, slices, ranges, mutation, stack/queue behavior.
- **Hashes**: string vs symbol keys, shorthand notation, nested access with `dig`.
- **Strings & Regex**: tokenization, substitutions, word extraction.
- **Blocks & Iterators**: `yield`, `map`, `each_with_index`, block-local variables.
- **Closures**: Procs, lambdas, differences in arity and return semantics.
- **Exceptions**: handling with `rescue`, ensuring cleanup with `ensure`.
- **Files**: safe iteration with `File.open`, custom helpers for guaranteed closure.
- **Enumerators**: external iteration (`next`), reverse traversal, `each_slice`.
- **Lazy evaluation**: infinite streams, predicate chaining, efficient filtering.
- **Functional style**: pipelines, passing lambdas as control structures.
- **Testing**: Minitest for unit testing core methods and pipelines.
