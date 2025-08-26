# =========================================
# 1) Arrays — creation, indexing, bounds
# =========================================

# Ruby Arrays are heterogeneous: numbers, strings, etc. can coexist.
# Access by index is O(1); printing uses Kernel#p to show inspect-style output.
sample_mix = [2.71828, "tart", 404]
p sample_mix.class  # => Array (ordered, mutable, indexable collection)
p sample_mix.length # => 3 (current number of elements)
# Indexing: 0-based, returns the element or nil if out of range.
# NOTE: In Ruby, out-of-bounds read returns nil (no exception). This differs from
# languages like Python that raise IndexError.
p sample_mix[0] # => 2.71828
p sample_mix[1] # => "tart"
p sample_mix[2] # => 404
p sample_mix[3] # => nil (past the end → nil)

# Creating an empty Array and growing it by assignment.
# Assigning to an index ≥ current length expands the array and fills any gaps with nil.
fresh_bucket = Array.new
p fresh_bucket.class        # => Array
p fresh_bucket.length       # => 0
p fresh_bucket[0] = "alpha" # write at index 0; array length becomes 1
p fresh_bucket[1] = "beta"  # write at index 1; array length becomes 2 (no gaps here)

# =========================================
# 2) Negative indexing
# =========================================
# Negative indices count from the end: -1 is last, -2 is second-to-last, etc.
# Out-of-range negative indices return nil rather than raising.
digits = [2, 4, 6, 8, 10]
p digits[-1]  # => 10 (last element)
p digits[-2]  # => 8
p digits[-99] # => nil (too far left → nil)

# =========================================
# 3) Array slices with [start, length]
# =========================================
# Slice reads return a NEW array containing up to 'length' elements
# starting at 'start'. Complexity is O(k) where k is the slice length,
# because Ruby copies those elements into a new array.
# Using a negative 'start' counts from the end (same convention as indexing).
digits = [2, 4, 6, 8, 10]
p digits[1, 3]  # => [4, 6, 8]   (take 3 items starting at index 1)
p digits[3, 1]  # => [8]         (take 1 item at index 3)
p digits[-3, 2] # => [6, 8]      (start 3 from the end; take 2)

# =========================================
# 4) Range indexing
# =========================================
# Purpose: demonstrate range-based slicing. `..` is inclusive, `...` is exclusive.
# Returns a NEW array (copy) without mutating the original.
digits = [2, 4, 6, 8, 10]
p digits[1..3]   # => [4, 6, 8]   inclusive end: grabs indexes 1,2,3
p digits[1...3]  # => [4, 6]      exclusive end: grabs indexes 1,2 (stops before 3)
p digits[3..3]   # => [8]         a single-element range is still an array
p digits[-3..-1] # => [6, 8, 10]  negative bounds count from the end

# =========================================
# 5) Element + slice assignment
# =========================================
# Purpose: show mutation via index and via slice (replace/insert/delete).
# Notes:
# - Assigning to an index beyond the current end grows the array and fills gaps with nil.
# - Slice assignment supports replacing multiple items at once (variable length on RHS).
digits = [2, 4, 6, 8, 10]

# Replace a single element by index (mutates in place).
digits[1]  = "owl"    # index 1 becomes "owl"
p digits

# Negative index update (still a single-element replacement).
digits[-3] = "fox"    # third from the end becomes "fox"
p digits

# Assigning an array to a single index stores a nested array (no flattening).
digits[3]  = [12, 14]
p digits

# Writing past the end expands the array; intermediate positions become nil.
digits[6]  = 777      # creates a hole at index 5 (nil)
p digits

# --- Slice replacement patterns ---
digits = [2, 4, 6, 8, 10]

# Replace 2 items starting at index 2 with a single string.
digits[2, 2] = "pear" # length can shrink or grow depending on RHS
p digits

# Insert without removing: length argument 0 ⇒ pure insertion.
digits[2, 0] = "lime"
p digits

# Replace 1 item with 3 items (array expansion).
digits[1, 1] = [42, 41, 40]
p digits

# Delete a contiguous range by assigning an empty array.
digits[0..3] = [] # removes indexes 0..3
p digits

# Assigning to a range beyond the end appends; any gap is filled with nil.
digits[5..6] = 91, 90
p digits

# =========================================
# 6) %w / %i literals
# =========================================
# Purpose: show shorthand for arrays of words and of symbols.
# `%w[...]` builds an array of strings separated by whitespace.
# `%i[...]` builds an array of symbols (no quotes needed).
fruits = %w[mango berry lemon peach grape]
p fruits[0] # => "mango"
p fruits[3] # => "peach"

animals = %i[lion wolf panda otter eagle]
p animals[0] # => :lion
p animals[3] # => :otter

# NOTE:
# - Use %W / %I (uppercase) if you need interpolation (e.g., "#{var}") inside the list.
# - For elements containing spaces, prefer a normal array with quoted strings.

# =========================================
# 7) Stack vs Queue using Array
# =========================================
# Purpose: contrast LIFO (stack) vs FIFO (queue) behaviors using core Array.
# Notes:
# - Array#push appends and returns the array itself; Array#pop removes from the end and returns the element.
# - Array#shift removes from the front (FIFO) but is O(n) due to internal shifting; fine for demos, less ideal at scale.

# Stack: push/pop operate on the end (LIFO)
color_stack = []
p color_stack.push "cyan"    # => ["cyan"] (push returns the mutated array)
p color_stack.push "magenta" # => ["cyan", "magenta"]
p color_stack.push "yellow"  # => ["cyan", "magenta", "yellow"]
p color_stack.pop            # => "yellow"   (pop returns the removed element)
p color_stack.pop            # => "magenta"
p color_stack.pop            # => "cyan"

# Queue: push adds to end, shift removes from front (FIFO)
city_queue = []
p city_queue.push "Paris" # => ["Paris"]
p city_queue.push "Lyon"  # => ["Paris", "Lyon"]
p city_queue.shift        # => "Paris"    (front of the queue)
p city_queue.shift        # => "Lyon"

# NOTE: For heavy queue workloads, consider `Queue` from stdlib (`require "thread"`) to avoid O(n) shifts.

# =========================================
# 8) Convenient accessors: first / last
# =========================================
# Purpose: show handy accessors; with an integer argument they return a NEW array slice.
series = [3, 6, 9, 12, 15, 18, 21]
p series.first    # => 3         (single element)
p series.first(4) # => [3, 6, 9, 12]  (array of the first 4)
p series.last     # => 21
p series.last(4)  # => [12, 15, 18, 21]

# =========================================
# 9) Hash basics
# =========================================
# Purpose: illustrate string keys, insertion, overwriting, and mixed key types.
# Notes:
# - Ruby Hash preserves insertion order.
# - Keys are compared by identity; "france" (String) is different from :france (Symbol).
capitals = { "france" => "paris", "spain" => "madrid", "italy" => "rome" }
p capitals.length                 # => 3      (current number of pairs)
p capitals["france"]              # => "paris" (lookup by key)
p capitals["germany"] = "berlin"  # inserts a new pair; returns the assigned value
p capitals[2025] = "future"       # any object can be a key (Integer here)
p capitals["italy"] = 7           # overwrite existing value (type can change)
p capitals

# Symbols style
# Two equivalent syntaxes when keys are simple symbols:
creatures = { :lion => "feline", :eagle => "avian", :shark => "marine" }  # hash-rocket (classic)
creatures = { lion: "feline", eagle: "avian", shark: "marine" }           # Ruby 1.9+ shorthand

# =========================================
# 10) Keyword capture into a hash
# =========================================
# Purpose: Show Ruby's hash shorthand that captures local variables as values.
# Behavior: Uses the variable names as keys and their current values as the hash values.
# NOTE: This shorthand (e.g., { first_name:, last_name: }) requires Ruby 3.1+.
first_name = "Ava"
last_name  = "Kensington"
profile = { first_name:, last_name: } # expands to { first_name: first_name, last_name: last_name }
p profile

# =========================================
# 11) Nested hashes/arrays + dig for safe traversal
# =========================================
# Purpose: Demonstrate access into nested structures and safer lookup with Hash#dig.
# - Direct indexing will raise if an intermediate step is nil (NoMethodError on [] or [:key]).
# - dig returns nil if any step is missing, avoiding exceptions during traversal.
library = {
  indie: [
    { title: "Starlight Road", year: 2019, authors: ["L. Vega", "M. Rhodes"] }
  ],
  scifi: [
    { title: "Echoes of Orion", year: 1984, authors: ["C. Durand", "T. Ellis"] }
  ]
}
p library[:indie][0][:authors][1]      # direct indexing: second author of first :indie entry
p library.dig(:scifi, 0, :authors, 0)  # safe traversal: first author of first :scifi entry (nil if any step missing)

# =========================================
# 12) Tokenization helper: extract words from string
# =========================================
# Purpose: Convert free text into a normalized list of "word-like" tokens.
# Steps:
#  1) Downcase for case-insensitive processing.
#  2) Use a regex to capture letters/digits/underscore and apostrophes.
#     - \w matches [A-Za-z0-9_]; the character class includes ' to keep contractions (e.g., "it's").
# Pitfalls:
#  - Hyphens, emojis, and non-ASCII punctuation are not included by this pattern; adjust if needed.
def tokens_from(text)
  # Downcase, then scan: \w matches letters/digits/underscore; keep apostrophes too
  text.downcase.scan(/[\w']+/)
end
p tokens_from("Ruby reads cleanly—it's often praised for developer joy!")

# =========================================
# 13) Frequency counting
# =========================================
# Goal: demonstrate how to build a frequency table with a Hash that defaults to 0.
# Key idea: Hash.new(0) lets you increment unseen keys without nil checks.

# Hash with default 0: unseen keys start at 0
word_count = Hash.new(0)
probe = "and"
word_count[probe] += 1  # first occurrence → 1
p word_count
word_count[probe] += 1  # increment again → 2
p word_count

# Explicit branch — same effect as using a default of 0, shown for learning purposes.
if word_count.key?(probe)
  word_count[probe] += 1
else
  word_count[probe] = 1
end
p word_count  # now 3 for "and"

# Count items with a loop — generic frequency counter for any enumerable.
# Complexity: O(n), where n = items.size.
def count_occurrences(items)
  tally = Hash.new(0)
  items.each do |element|
    tally[element] += 1
  end
  tally
end
p count_occurrences(["apple", "banana", "apple", "cherry", "banana", "apple"])
# => {"apple"=>3, "banana"=>2, "cherry"=>1}

# =========================================
# 14) Pipeline: tokenize -> count -> sort -> top N
# =========================================
# Goal: show a simple text-processing pipeline.
# Steps: normalize → tokenize → count → sort → select top-k.

# Text changed to avoid any overlap with source material
sample_text = <<~TEXT
  Clear code tells a story. Favor small functions, honest names,
  and simple data shapes. Practice daily and your future self will thank you.
TEXT

# Tokenizer: lowercase + keep words/apostrophes (e.g., "dev's").
# Adjust the regex if you need hyphens/emojis/Unicode categories.
def extract_words(text)
  text.downcase.scan(/[\w']+/)
end

# 1) Tokenize
word_list = extract_words(sample_text)

# 2) Count word frequency (reuses the helper above)
counts = count_occurrences(word_list)

# 3) Sort ascending by count; returns array of [word, count] pairs.
sorted = counts.sort_by { |word, count| count }

# 4) Take the top 5 and print from most to least frequent.
top_five = sorted.last(5)
top_five.reverse_each do |word, count|
  puts "#{word}: #{count}"
end

# =========================================
# 15) Tests (Minitest) for extract_words + count_occurrences
# =========================================
# Purpose: minimal unit tests to validate tokenization and counting behavior.
# Run: `ruby this_file.rb` — Minitest auto-runs when required.

require "minitest/autorun"

class TestExtractWords < Minitest::Test
  def test_empty_string
    assert_equal([], extract_words(""))
    assert_equal([], extract_words(" "))
  end

  def test_single_word
    assert_equal(["ruby"], extract_words("ruby"))
    assert_equal(["ruby"], extract_words(" ruby "))
  end

  def test_many_words
    assert_equal(%w[write tiny ruby methods], extract_words("Write tiny Ruby methods"))
  end

  def test_ignores_punctuation
    assert_equal(["clean", "dev's", "guide"], extract_words("clean, dev's guide!"))
  end
end

class TestCountOccurrences < Minitest::Test
  def test_empty_list
    assert_equal({}, count_occurrences([]))
  end

  def test_single_word
    assert_equal({ "ruby" => 1 }, count_occurrences(["ruby"]))
  end

  def test_two_different_words
    assert_equal({ "ruby" => 1, "rocks" => 1 }, count_occurrences(%w[ruby rocks]))
  end

  def test_two_words_with_adjacent_repeat
    assert_equal({ "ruby" => 2, "rocks" => 1 }, count_occurrences(%w[ruby ruby rocks]))
  end

  def test_two_words_with_non_adjacent_repeat
    assert_equal({ "ruby" => 2, "rocks" => 1 }, count_occurrences(%w[ruby rocks ruby]))
  end
end

# Variants of the same pipeline using #tally (Ruby 2.7+)
# NOTE: Array#tally builds a frequency hash directly; handy for quick scripts.  
tokens = extract_words(sample_text)
tally  = tokens.tally
sorted = tally.sort_by { |word, count| count }
top_five = sorted.last(5)
top_five.reverse_each { |w, c| puts "#{w}: #{c}" }

# Compact, chainable style — useful for REPL/demos.
puts extract_words(sample_text)
  .tally
  .sort_by { |w, c| c }
  .last(5)
  .reverse
  .map { |w, c| "#{w}: #{c}" }

# Same pipeline with taps to inspect intermediate stages (debug-friendly).
puts extract_words(sample_text)
  .tally
  .sort_by { |w, c| c }
  .tap   { |r| puts "sorted tally: #{r}\n\n" }
  .last(5)
  .tap   { |r| puts "only the last five: #{r}\n\n" }
  .reverse
  .tap   { |r| puts "reversed: #{r}\n\n" }
  .map   { |w, c| "#{w}: #{c}" }

# =========================================
# 16) Enumerable basics: each, running totals
# =========================================
# Purpose: illustrate core Enumerable patterns—iteration, running state,
# and numeric operations—without altering the original data.

some_array = [2, 4, 6, 8]

# For-each iteration over values; side-effect is printing.
# Complexity: O(n) for n elements. Does not mutate the array.
some_array.each { |value| puts value * 3 } # apply op to each item

# Running total (prefix sum) tracked in an external variable.
# NOTE: `to_f` forces floating-point division; otherwise integer division would truncate.
sum = 0
some_array.each do |value|
  sum += value          # accumulate as we go
  puts value.to_f / sum # ratio at this step (educational output)
end

# Another accumulator example: sum of squares.
# Scope of `sum` is reset; inner `square` is local to the block.
sum = 0
[2, 3, 4, 5].each do |value|
  square = value * value
  sum += square
end
puts sum

# =========================================
# 17) Class, methods, exceptions, scope/shadowing
# =========================================
# Purpose: show a minimal class with an initializer, instance method,
# exception handling, and Ruby scoping rules (shadowing and block-local).
class Polygon
  # Convert input to Float to validate and normalize numeric input early.
  # NOTE: Float(side) will raise if `side` cannot be converted—useful fail-fast behavior.
  def initialize(side:) ; @side = Float(side) ; end

  # Simple side-effectful method (I/O via puts); returns nil.
  def draw ; puts "Drawing a polygon of side #{@side}" ; end
end

poly = Polygon.new(side: 4)

# Reuse of the sum-of-squares pattern; this is independent of the class above.
sum = 0
[2, 3, 4, 5].each do |value|
  square = value * value
  sum += square
end
puts sum

# Basic exception handling. If `draw` were missing, NoMethodError would be caught.
begin
  poly.draw
rescue NoMethodError => e
  puts ">>> Error : #{e.class} - #{e.message}"
  puts e.backtrace.first
end

# Shadowing example: the block parameter `thing` hides the outer `thing` temporarily.
# After the block, the outer binding is intact.
thing = "outer label"
[1, 2].each { |thing| puts thing } # prints 1 then 2
puts thing                         # still "outer label"

# Block-local variable via semicolon—`name` after the semicolon is local to the block only.
# The outer `name` remains unchanged.
name = "kept outside"
sum = 0
[2, 3, 4, 5].each do |value; name|
  name = value * value
  sum += name
end
puts sum
puts name

# Numbered block parameters (_1, _2, …) avoid naming when args are obvious (Ruby 2.7+).
[9, 10].each { puts _1 }

# =========================================
# 18) Yield & custom iterators
# =========================================
# Purpose: demonstrate yielding to blocks, a custom external iterator pattern,
# and educational reimplementations of common behaviors.

# A tiny iterator that yields exactly twice; control is inverted to the caller via `yield`.
def repeat_twice
  yield
  yield
end
repeat_twice { puts "Hi there" }  # block is executed twice

# Fibonacci sequence generator up to `limit`, yielding each term to the given block.
# Uses tuple assignment to advance the pair (a, b). Stops once `a` exceeds the limit.
def fib_until(limit)
  a, b = 1, 1
  while a <= limit
    yield a
    a, b = b, a + b
  end
end

# Two equivalent block syntaxes: explicit parameter vs numbered parameter.
p fib_until(800) { |n| print n, " " }
p fib_until(800) { print _1, " " }

# Simple traversal over a different dataset (even integers here).
[2, 4, 6, 8, 10].each { |n| puts n }

# Extend Array with a minimal "find first" for teaching (do not override built-ins in production).
# Returns the first element satisfying the predicate; otherwise nil.
class Array
  def detect_first
    each do |value|
      return value if yield(value)
    end
    nil
  end
end

puts [2, 4, 6, 8, 10].detect_first { |num| num * num > 50 }
puts [2, 4, 6, 8, 10].detect_first { _1 * _1 > 60 }

# Map demonstrations: String#succ advances to the next lexicographic value.
p %w[R U B Y].map { |ch| ch.succ }
p %w[R U B Y].map { _1.succ }

# Educational remap: a custom map variant to reveal the mechanics (buffer + push).
# Returns a NEW array; input is not mutated.
class Array
  def map_edu
    out = []
    each do |value|
      out << yield(value)
    end
    out
  end
end

p [3, 5, 7].map_edu { |n| n * 2 }

# =========================================
# 19) File iteration (read lines)
# =========================================
# Purpose: demonstrate safe buffered reading with File.open blocks.
# - When you pass a block to File.open, Ruby auto-closes the handle at block end.
# - Iteration is lazy over the file; each line includes its trailing newline by default.
#   (Use String#chomp if you need to strip it.)

# Open the file and iterate over each line (auto-closes at block end)
path = File.join(__dir__, "testfile.txt")
File.open(path) do |file_handle|
  file_handle.each do |row|
    puts "Read: #{row}"  # process each row as it streams from disk
  end
end

# Reopen and iterate with an index (handy for diagnostics)
# NOTE: with_index starts at 0 by default; use with_index(1) if you prefer 1-based.
path = File.join(__dir__, "testfile.txt")
File.open(path) do |file_handle|
  file_handle.each.with_index do |row, lineno|
    puts "Line #{lineno}: #{row}"
  end
end

# =========================================
# 20) Reduce with changed datasets
# =========================================
# Purpose: show common reduce/inject patterns for sum/product and different initial values.
# Notes:
# - With an initial value, that value seeds the accumulator (e.g., 0 for sum, 1 for product).
# - Without an initial value, the first array element is used as the accumulator.
# - Passing a Symbol (:+, :*) calls that method on the accumulator for each element.
# - Array#sum is a convenient/optimized shorthand for summing numerics.
# - Array#product(other) returns the Cartesian product (pairs), not multiplication.

p [2, 4, 6, 8].reduce(0) { |sum, element| sum + element }
p [2, 4, 6, 8].reduce(0) { _1 + _2 }
p [2, 4, 6, 8].reduce(1) { |product, element| product * element }
p [2, 4, 6, 8].reduce(1) { _1 * _2 }

p [2, 4, 6, 8].reduce { |sum, element| sum + element }
p [2, 4, 6, 8].reduce { _1 + _2 }
p [2, 4, 6, 8].reduce { |product, element| product * element }
p [2, 4, 6, 8].reduce { _1 * _2 }

p [2, 4, 6, 8].reduce(:+)
p [2, 4, 6, 8].reduce(:*)
p [2, 4, 6, 8].sum
p [2, 4, 6, 8].product([3, 5, 7])  # Cartesian product with changed values

# =========================================
# 21) Ensuring closure with ensure + custom file helpers
# =========================================
# Purpose: show robust resource management patterns.
# - open_and_process wraps File.open and guarantees close via `ensure`, even on exceptions.
# - my_open mirrors File.open’s block form: returns the file when no block is given;
# yields and auto-closes when a block is given.
# NOTE: Monkey-patching core classes (like File) is fine for learning, but avoid in production
# libraries unless namespaced to prevent surprises.

class File
  def self.open_and_process(*args)
    f = File.open(*args)
    begin
      yield f
    ensure
      f.close # always closes, even if the block raises
    end
  end
end

path = File.join(__dir__, "testfile.txt")
File.open_and_process(path, "r") do |file|
  while (line = file.gets)  # gets returns nil at EOF; loop stops naturally
    puts line
  end
end

class File
  def self.my_open(* args)
    file = File.new(* args)
    return file unless block_given? # behave like File.open: return handle if no block
    result = yield file             # let the caller operate on the handle
    file.close                      # ensure closure after the block
    result
  end
end

path = File.join(__dir__, "testfile.txt")
File.my_open(path, "r") do |f|
  f.each_line do |line|
    puts "line read: #{line}"
  end
end

# =========================================
# 22) Procs, lambdas, closures — capturing behavior
# =========================================
# Purpose: demonstrate how to turn blocks into callable objects (Proc/lambda),
#          store them, pass them around, and leverage closures to capture state.
# Key ideas:
# - `&param` converts a block to a Proc object.
# - `lambda` is a Proc with stricter arity and different `return` semantics than `proc`.
# - Closures capture surrounding variables by reference (state can evolve over time).

class CallbackDemo
  # Store a block as a callback Proc on the instance.
  # NOTE: If no block is given, @callback will be nil; calling it would raise.
  def store_block(&action)
    @callback = action
  end

  # Invoke the stored callback with a single argument.
  def call_with(arg)
    @callback.call(arg)
  end
end

cb = CallbackDemo.new
cb.store_block { |param| puts "Arg: #{param}" }
cb.call_with(123)

# Turn an implicit block into an explicit Proc value and return it.
def capture_block(&blk)
  blk
end

# Example: get a Proc back and call it multiple times.
fn = capture_block { |x| puts "You passed: #{x}" }
fn.call(111)
fn.call("kiwi")

# Lambdas are Procs with strict arity and `return` only exits the lambda itself.
fn = ->(x) { puts "Lambda says: #{x}" }
fn.call(222)
fn.call("mango")

fn = lambda { |x| puts "Lambda (long) says: #{x}" }
fn.call(333)
fn.call "papaya"

# Plain `proc` and `Proc.new` are equivalent constructors for lenient-arity Procs.
# (They accept missing extra args as nil, and extra args are ignored.)
fn = proc { |x| puts "proc says: #{x}" }
fn.call(444)
fn.call("guava")

fn = Proc.new { |x| puts "Proc.new says: #{x}" }
fn.call(555)
fn.call("fig")

# Closure that remembers captured variables.
# The returned lambda multiplies its argument by `seed` captured from the outer scope.
def make_multiplier(seed)
  ->(n) { seed * n }
end
m1 = make_multiplier(17)
puts m1.call(3)
puts m1.call(4)
m2 = make_multiplier("Yo ")
puts m2.call(3)

# Stateful closure: `acc` persists between calls because it is captured by the lambda.
def doubling_factory
  acc = 2
  -> { acc += acc }
end

doubler = doubling_factory
puts doubler.call  # 4
puts doubler.call  # 8
puts doubler.call  # 16

# Lambdas with different arities (number of required parameters).
# NOTE: Lambdas enforce arity; using fewer/more args raises ArgumentError unless you use *rest.
lam1 = -> a { puts "In lam1 with #{a}" }
lam2 = -> x, y { puts "In lam2 with #{x} and #{y}" }
lam3 = ->(x, y) { puts "In lam3 with #{x} and #{y}" }

puts lam1.call "alpha"
puts lam2.call "beta", "citrus"
puts lam3.call "date", "elderberry"

# =========================================
# 23) Functional control structures using callables
# =========================================
# Purpose: show how to encode control flow by passing behavior (Procs/lambdas) as data.

# Branching by calling the appropriate callable based on a condition.
def branch_if(condition, then_clause, else_clause)
  if condition
    then_clause.call
  else
    else_clause.call
  end
end

5.times do |val|
  branch_if(
    val < 2,
    -> { puts "#{val} is small" },
    -> { puts "#{val} is big" }
  )
end

# While-like loop driven by a predicate callable.
def loop_while(cond, &body)
  while cond.call
    body.call
  end
end

counter = 0
loop_while(-> { counter < 3 }) do
  puts counter
  counter += 1
end

# Variadic lambda examples: collect remaining args with *rest and optionally a &block.
# NOTE: In lambdas, arity still applies to the required parameters (before *rest).
varargs1 = lambda do |a, *rest, &block|
  puts "a = #{a.inspect}"
  puts "rest = #{rest.inspect}"
  block.call
end
varargs1.call(1, 2, 3, 4) { puts "in block1" }

varargs2 = ->(a, *rest, &block) do
  puts "a = #{a.inspect} "
  puts "rest = #{rest.inspect} "
  block.call
end
varargs2.call(5, 6, 7, 8) { puts "in block2" }

# =========================================
# 24) Enumerators (external iteration), reverse_each, next
# =========================================
# Purpose: demonstrate creating external iterators with `to_enum` / `enum_for`,
#          consuming them with `next`, and using enumeration helpers.
# NOTE: Calling `next` past the end raises StopIteration.

arr = [99, "ruby", :ok]
enum_arr = arr.to_enum
p enum_arr.next # 99
p enum_arr.next # "ruby"

pairs = { sun: "star", earth: "planet" }
enum_hash = pairs.to_enum
p enum_hash.next # [:sun, "star"]
p enum_hash.next # [:earth, "planet"]

# Reverse traversal via reverse_each
enum_rev = arr.to_enum(:reverse_each)
p enum_rev.next # :ok
p enum_rev.next # "ruby"

# `each` itself returns an Enumerator when called without a block, here assigned as enum_each.
enum_each = arr.each
p enum_each.next # 99
p enum_each.next # "ruby"


# Two enumerators with different lengths; the loop will raise StopIteration
# when the shorter one (`short_enum`) is exhausted. This is intentional for demo.
short_enum = [10, 20, 30].to_enum
long_enum  = ("A".."Z").to_enum
loop do
  puts "#{short_enum.next} - #{long_enum.next}"
end

# Build arrays of [value, index] pairs using each_with_index / with_index.
result = []
%w[red green blue].each_with_index { |item, index| result << [item, index] }
p result

result = []
"ruby".each_char.each_with_index { |ch, index| result << [ch, index] }
p result

result = []
"ruby".each_char.with_index { |ch, index| result << [ch, index] }
p result

# Map directly from the enumerator with with_index.
p "ruby".each_char.with_index.map { |ch, index| [ch, index] }

# Materialize a character enumerator to an array.
enum_chars = "ruby".each_char
p enum_chars.to_a

# Create an enumerator for slicing a range into groups of 3.
enum_in_threes = (10..20).enum_for(:each_slice, 3)
p enum_in_threes.to_a

# =========================================
# 25) Building enumerators manually & with Enumerator.produce
# =========================================
# Purpose: show two ways to build streams:
#   (1) manual Enumerator.new with an explicit yielder,
#   (2) Enumerator.produce for succinct “next state” generation.
# Notes:
# - Both approaches are stateful and can model infinite sequences.
# - Consumption happens via `next`, `take`, `first`, etc.

# Manual enumerator that yields triangular numbers (1, 3, 6, 10, …).
# The block retains local state (`total`, `step`), and uses `yielder.yield(value)`
# to push each computed element to the consumer. The `loop do` makes it infinite.
tri_seq = Enumerator.new do |yielder|
  total = 0
  step  = 1
  loop do
    total += step
    step  += 1
    yielder.yield(total)
  end
end

# Consume five elements via repeated `next`. (StopIteration would occur if the
# generator were finite and we asked for too many, but this one is infinite.)
5.times { print tri_seq.next, " " }
puts

# Produce a pair-evolving sequence using Enumerator.produce.
# Each step returns the next pair [total, step]; `.first(5)` takes a finite prefix,
# and `.map { _1.first }` projects the first component from each pair.
tri_pairs = Enumerator.produce([2, 3]) do |total, step|
  [total + step, step + 1]
end
p tri_pairs.first(5).map { _1.first }

# =========================================
# 26) Lazy streams + predicates
# =========================================
# Purpose: compose infinite sequences with lazy evaluation and filter them with predicates.
# Notes:
# - `.lazy` defers work until a terminal operation (e.g., `first(10)`).
# - Chaining `.select` is efficient with lazy enumerators because items are processed on demand.

class NaturalFlow
  # Infinite stream of natural numbers starting at 1.
  # Enumerator.produce generates successive values; `.lazy` enables demand-driven processing.
  def stream
    Enumerator.produce(1) { |n| n + 1 }.lazy
  end
end
# Take the first 10 naturals (forces just 10 elements to be computed).
p NaturalFlow.new.stream.first(10)
# Filter lazily: multiples of 4, then slice the first 10 matches.
p NaturalFlow.new.stream
  .select { (_1 % 4).zero? }
  .first(10)

# Palindrome predicate (string-based): e.g., 121 → "121" equals its reverse.
# NOTE: Leading zeros are not present for integers, so no ambiguity there.
def palindromic?(n)
  s = n.to_s
  s == s.reverse
end
# Compose filters: multiples of 4 that are also palindromic.
p NaturalFlow.new.stream
  .select { (_1 % 4).zero? }
  .select { palindromic?(_1) }
  .first(10)

# Reuse intermediate pipelines: derive a filtered stream, then further refine it.
multiples_of_four = NaturalFlow.new.stream.select { (_1 % 4).zero? }
p multiples_of_four.first(10)

mf_palindromes = multiples_of_four.select { palindromic?(_1) }
p mf_palindromes.first(10)

# Same idea using callable predicates (lambdas) and `&` to pass them as blocks.
# This improves reusability and testability of the predicate logic.
multiple_of_four = -> n { (n % 4).zero? }
is_palindrome = -> n { s = n.to_s; s == s.reverse }
p NaturalFlow.new.stream
  .select(&multiple_of_four)
  .select(&is_palindrome)
  .first(10)

# Another lazy stream based on a pair state, projected to the first component.
# Because it’s lazy, only the requested prefix is evaluated.
pair_growth = Enumerator.produce([2, 3]) do |sum, step|
  [sum + step, step + 1]
end.lazy.map { _1.first }
p pair_growth.first(5)

