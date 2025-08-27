# =========================================
# 1) Arrays — creation, indexing, bounds
# =========================================

# Ruby Arrays are heterogeneous: they can store different types (numbers, strings, etc.)
# Access by index is O(1); Kernel#p prints the inspect-style representation (debug view).
sample_mix = [2.71828, "tart", 404] # create an array with a float, a string, and an integer
p sample_mix.class                  # => Array (confirms the object type)
p sample_mix.length                 # => 3 (current number of elements)

# Indexing: arrays are 0-based. Out-of-bounds access returns nil instead of raising an error.
p sample_mix[0]                     # => 2.71828 (first element)
p sample_mix[1]                     # => "tart"  (second element)
p sample_mix[2]                     # => 404     (third element)
p sample_mix[3]                     # => nil     (past the end → returns nil, no exception)

# Creating an empty Array and growing it by assignment.
fresh_bucket = Array.new            # create an empty array
p fresh_bucket.class                # => Array (confirm type)
p fresh_bucket.length               # => 0 (starts empty)

# Assigning to an index expands the array automatically.
p fresh_bucket[0] = "alpha"         # assign at index 0 → length becomes 1
p fresh_bucket[1] = "beta"          # assign at index 1 → length becomes 2

# =========================================
# 2) Negative indexing
# =========================================
# Negative indices count backward: -1 = last, -2 = second-to-last, etc.
# Out-of-range negative indices return nil instead of an error.
digits = [2, 4, 6, 8, 10] # array of integers
p digits[-1]              # => 10 (last element)
p digits[-2]              # => 8  (second-to-last element)
p digits[-99]             # => nil (too far left → returns nil)

# =========================================
# 3) Array slices with [start, length]
# =========================================
# Syntax: array[start, length]
# - Returns a NEW array containing up to `length` elements starting at `start`.
# - If start is negative, counting begins from the end.
digits = [2, 4, 6, 8, 10]
p digits[1, 3]            # => [4, 6, 8] (3 items starting at index 1)
p digits[3, 1]            # => [8]       (1 item at index 3)
p digits[-3, 2]           # => [6, 8]    (start 3 from the end; take 2 items)

# =========================================
# 4) Range indexing
# =========================================
# Purpose: demonstrate range-based slicing.
# - `..` is inclusive of the end index.
# - `...` is exclusive of the end index.
# Always returns a NEW array (original remains unchanged).
digits = [2, 4, 6, 8, 10]
p digits[1..3]            # => [4, 6, 8] inclusive end: indices 1,2,3
p digits[1...3]           # => [4, 6]    exclusive end: indices 1,2 only
p digits[3..3]            # => [8]       single-element slice is still an array
p digits[-3..-1]          # => [6, 8, 10] negative indices work in ranges too

# =========================================
# 5) Element + slice assignment
# =========================================
# Purpose: show mutation via index and via slice (replace/insert/delete).
# Notes:
# - Assigning to an index beyond the current end grows the array and fills gaps with nil.
# - Slice assignment supports replacing multiple items at once (variable length on RHS).
digits = [2, 4, 6, 8, 10]   # start with a simple integer array

# Replace a single element by index (mutates in place).
digits[1]  = "owl"          # write "owl" at index 1 (replaces 4)
p digits                    # print mutated array

# Negative index update (still a single-element replacement).
digits[-3] = "fox"          # -3 is third from the end → replace 6 with "fox"
p digits                    # print current state

# Assigning an array to a single index stores a nested array (no flattening).
digits[3]  = [12, 14]       # set index 3 to an array; element is now a nested array
p digits                    # confirm nested structure

# Writing past the end expands the array; intermediate positions become nil.
digits[6]  = 777            # index 6 is beyond end → index 5 becomes nil, length grows
p digits                    # print with the nil “hole”

# --- Slice replacement patterns ---
digits = [2, 4, 6, 8, 10]   # reset baseline array

# Replace 2 items starting at index 2 with a single string.
digits[2, 2] = "pear"       # remove [6, 8] and insert "pear" (length shrinks by 1)
p digits                    # show updated array

# Insert without removing: length argument 0 ⇒ pure insertion.
digits[2, 0] = "lime"       # insert "lime" at index 2; nothing removed (length +1)
p digits                    # verify insertion

# Replace 1 item with 3 items (array expansion).
digits[1, 1] = [42, 41, 40] # replace the element at index 1 with three elements (length +2)
p digits                    # print expanded result

# Delete a contiguous range by assigning an empty array.
digits[0..3] = []           # remove elements at indices 0..3 (range assignment)
p digits                    # show remaining tail

# Assigning to a range beyond the end appends; any gap is filled with nil.
digits[5..6] = 91, 90       # write past end: fill missing indices with nil, then append 91, 90
p digits                    # confirm final structure

# =========================================
# 6) %w / %i literals
# =========================================
# Purpose: show shorthand for arrays of words and of symbols.
# `%w[...]` builds an array of strings separated by whitespace.
# `%i[...]` builds an array of symbols (no quotes needed).
fruits = %w[mango berry lemon peach grape] # quick array of strings
p fruits[0]                                # => "mango" (index access)
p fruits[3]                                # => "peach"

animals = %i[lion wolf panda otter eagle]  # quick array of symbols
p animals[0]                               # => :lion
p animals[3]                               # => :otter

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
color_stack = []  # start with an empty stack
p color_stack.push "cyan"    # push returns the mutated array → ["cyan"]
p color_stack.push "magenta" # now ["cyan", "magenta"]
p color_stack.push "yellow"  # now ["cyan", "magenta", "yellow"]
p color_stack.pop            # => "yellow" (last in, first out)
p color_stack.pop            # => "magenta"
p color_stack.pop            # => "cyan"

# Queue: push adds to end, shift removes from front (FIFO)
city_queue = []              # start with an empty queue
p city_queue.push "Paris"    # enqueue "Paris" → ["Paris"]
p city_queue.push "Lyon"     # enqueue "Lyon"  → ["Paris", "Lyon"]
p city_queue.shift           # => "Paris" (dequeue from front)
p city_queue.shift           # => "Lyon"  (then queue becomes empty)

# NOTE: For heavy queue workloads, consider `Queue` from stdlib (`require "thread"`) to avoid O(n) shifts.

# =========================================
# 8) Convenient accessors: first / last
# =========================================
# Purpose: show handy accessors; with an integer argument they return a NEW array slice.
series = [3, 6, 9, 12, 15, 18, 21] # create an array of multiples of 3
p series.first                     # => 3  (returns the first element only)
p series.first(4)                  # => [3, 6, 9, 12] (returns an array of first 4 elements)
p series.last                      # => 21 (returns the last element only)
p series.last(4)                   # => [12, 15, 18, 21] (returns an array of last 4 elements)

# =========================================
# 9) Hash basics
# =========================================
# Purpose: illustrate string keys, insertion, overwriting, and mixed key types.
# Notes:
# - Ruby Hash preserves insertion order.
# - Keys are compared by identity; "france" (String) is different from :france (Symbol).
capitals = { "france" => "paris", "spain" => "madrid", "italy" => "rome" }
p capitals.length                                                         # => 3 (three key-value pairs initially)
p capitals["france"]                                                      # => "paris" (lookup by string key)
p capitals["germany"] = "berlin"                                          # adds new key-value pair, returns "berlin"
p capitals[2025] = "future"                                               # integer keys are allowed too
p capitals["italy"] = 7                                                   # overwrite value for "italy"; type can change
p capitals                                                                # print the full hash

# Symbols style
# Two equivalent syntaxes when keys are simple symbols:
creatures = { :lion => "feline", :eagle => "avian", :shark => "marine" }  # hash-rocket (classic)
creatures = { lion: "feline", eagle: "avian", shark: "marine" }           # Ruby 1.9+ shorthand syntax

# =========================================
# 10) Keyword capture into a hash
# =========================================
# Purpose: Show Ruby's hash shorthand that captures local variables as values.
first_name = "Ava"                    # local variable
last_name  = "Kensington"             # local variable
profile = { first_name:, last_name: } # expands to { first_name: "Ava", last_name: "Kensington" }
p profile                             # print generated hash

# =========================================
# 11) Nested hashes/arrays + dig for safe traversal
# =========================================
# Purpose: demonstrate safe vs unsafe navigation into nested data.
library = {                              # define a hash with two top-level keys
  indie: [                               # key :indie points to an array
    { title: "Starlight Road",           # first element is a hash representing a book
    year: 2019,                          # publication year
    authors: ["L. Vega", "M. Rhodes"] }  # authors is an array of strings
  ],
  scifi: [                               # key :scifi points to another array
    { title: "Echoes of Orion",          # another hash for a book
    year: 1984,                          # year
    authors: ["C. Durand", "T. Ellis"] } # authors array
  ]
}
p library[:indie][0][:authors][1]        # => "M. Rhodes"
                                         # Breakdown:
                                         # library[:indie] → array under :indie
                                         # [0] → first book hash
                                         # [:authors] → authors array
                                         # [1] → second author string

p library.dig(:scifi, 0, :authors, 0)    # => "C. Durand"
                                         # dig(:scifi, 0, :authors, 0) traverses safely:
                                         # returns nil instead of raising if any step is missing.

# =========================================
# 12) Tokenization helper: extract words from string
# =========================================
# Purpose: Convert free text into a normalized list of word-like tokens.
def tokens_from(text)
  # Downcase the text for case-insensitive analysis
  # Regex [\w']+ matches:
  # - \w = letters, digits, underscore
  # - ' included for contractions (e.g. "it's")
  text.downcase.scan(/[\w']+/)
end
p tokens_from("Ruby reads cleanly—it's often praised for developer joy!") # => ["ruby", "reads", "cleanly", "it's", "often", "praised", "for", "developer", "joy"]

# =========================================
# 13) Frequency counting
# =========================================
# Goal: build a frequency table with Hash.new(0) so increments work on unseen keys.

word_count = Hash.new(0)                                                       # hash defaults to 0 for missing keys
probe = "and"                                                                  # choose a test word
word_count[probe] += 1                                                         # first occurrence → count = 1
p word_count
word_count[probe] += 1                                                         # increment again → count = 2
p word_count

# Explicit branch: equivalent to using Hash.new(0), shown for clarity.
if word_count.key?(probe)                                                      # check if "and" exists as key
  word_count[probe] += 1                                                       # if yes, increment
else
  word_count[probe] = 1                                                        # if no, initialize to 1
end
p word_count                                                                   # => {"and"=>3}

# Define a generic counter function for any enumerable
def count_occurrences(items)
  tally = Hash.new(0)                                                          # start with empty hash, default 0
  items.each do |element|                                                      # loop over each item
    tally[element] += 1                                                        # increment its counter
  end
  tally                                                                        # return frequency table
end
p count_occurrences(["apple", "banana", "apple", "cherry", "banana", "apple"]) # => {"apple"=>3, "banana"=>2, "cherry"=>1}

# =========================================
# 14) Pipeline: tokenize -> count -> sort -> top N
# =========================================
# Goal: show a simple text-processing pipeline.

sample_text = <<~TEXT
  Clear code tells a story. Favor small functions, honest names,
  and simple data shapes. Practice daily and your future self will thank you.
TEXT

# Tokenizer: lowercase + keep words/apostrophes
def extract_words(text)
  text.downcase.scan(/[\w']+/)                  # same regex pattern as before
end

# 1) Tokenize
word_list = extract_words(sample_text)          # array of normalized words

# 2) Count word frequency
counts = count_occurrences(word_list)           # hash: {word => count}

# 3) Sort ascending by count
sorted = counts.sort_by { |word, count| count } # returns array of [word, count] pairs

# 4) Take the top 5 and print from most to least frequent
top_five = sorted.last(5)                       # extract last 5 (highest counts)
top_five.reverse_each do |word, count|          # iterate in descending order
  puts "#{word}: #{count}"                      # print "word: count"
end

# =========================================
# 15) Tests (Minitest) for extract_words + count_occurrences
# =========================================
# Purpose: minimal unit tests to validate tokenization and counting behavior.
# Run: `ruby this_file.rb` — Minitest auto-runs when required.

require "minitest/autorun"                                                              # load Minitest framework (runs tests automatically)

# -------------------------------
# Test suite for extract_words
# -------------------------------
class TestExtractWords < Minitest::Test
  def test_empty_string
    assert_equal([], extract_words(""))                                                 # empty string → no tokens
    assert_equal([], extract_words(" "))                                                # whitespace only → no tokens
  end

  def test_single_word
    assert_equal(["ruby"], extract_words("ruby"))                                       # single word lowercased
    assert_equal(["ruby"], extract_words(" ruby "))                                     # leading/trailing spaces ignored
  end

  def test_many_words
    assert_equal(%w[write tiny ruby methods], extract_words("Write tiny Ruby methods")) # => lowercase + split into tokens
  end

  def test_ignores_punctuation
    assert_equal(["clean", "dev's", "guide"], extract_words("clean, dev's guide!"))     # punctuation removed, apostrophe preserved
  end
end

# -------------------------------
# Test suite for count_occurrences
# -------------------------------
class TestCountOccurrences < Minitest::Test
  def test_empty_list
    assert_equal({}, count_occurrences([]))                                             # empty input → empty hash
  end

  def test_single_word
    assert_equal({ "ruby" => 1 }, count_occurrences(["ruby"]))                          # one word counted once
  end

  def test_two_different_words
    assert_equal({ "ruby" => 1, "rocks" => 1 }, count_occurrences(%w[ruby rocks]))      # both words appear once
  end

  def test_two_words_with_adjacent_repeat
    assert_equal({ "ruby" => 2, "rocks" => 1 }, count_occurrences(%w[ruby ruby rocks])) # "ruby" twice, "rocks" once
  end

  def test_two_words_with_non_adjacent_repeat
    assert_equal({ "ruby" => 2, "rocks" => 1 }, count_occurrences(%w[ruby rocks ruby])) # order doesn’t matter, counts still correct
  end
end

# -------------------------------
# Variants of the pipeline using Array#tally (Ruby 2.7+)
# -------------------------------
# NOTE: Array#tally directly counts frequencies into a hash. 
tokens = extract_words(sample_text)                  # tokenize text
tally  = tokens.tally                                # tally frequencies
sorted = tally.sort_by { |word, count| count }       # sort ascending by frequency
top_five = sorted.last(5)                            # select top 5 frequent words
top_five.reverse_each { |w, c| puts "#{w}: #{c}" }   # print in descending order

# Compact, chainable style — useful for REPL/demos.
puts extract_words(sample_text)                      # tokenize
  .tally                                             # count
  .sort_by { |w, c| c }                              # sort ascending
  .last(5)                                           # take last 5
  .reverse                                           # reverse for descending order
  .map { |w, c| "#{w}: #{c}" }                       # format as "word: count"

# Same pipeline with taps to inspect intermediate stages (debug-friendly).
puts extract_words(sample_text)
  .tally
  .sort_by { |w, c| c }
  .tap   { |r| puts "sorted tally: #{r}\n\n" }       # debug: show sorted tally
  .last(5)
  .tap   { |r| puts "only the last five: #{r}\n\n" } # debug: show just last 5
  .reverse
  .tap   { |r| puts "reversed: #{r}\n\n" }           # debug: show reversed order
  .map   { |w, c| "#{w}: #{c}" }                     # final formatted output

# =========================================
# 16) Enumerable basics: each, running totals
# =========================================
# Purpose: illustrate core Enumerable patterns—iteration, running state,
# and numeric operations—without altering the original data.

some_array = [2, 4, 6, 8]                  # define a sample array of integers

# For-each iteration over values; side-effect is printing.
# Complexity: O(n) for n elements. Original array not modified.
some_array.each { |value| puts value * 3 } # multiply each by 3 and print

# Running total (prefix sum) tracked in an external variable.
# NOTE: `to_f` ensures floating-point division (avoids integer truncation).
sum = 0
some_array.each do |value|
  sum += value                             # accumulate progressively
  puts value.to_f / sum                    # print ratio at this step
end

# Another accumulator example: sum of squares.
sum = 0                                    # reset sum
[2, 3, 4, 5].each do |value|
  square = value * value                   # compute square
  sum += square                            # accumulate
end
puts sum                                   # => 54 (4 + 9 + 16 + 25)

# =========================================
# 17) Class, methods, exceptions, scope/shadowing
# =========================================
# Purpose: show a minimal class with an initializer, instance method,
# exception handling, and Ruby scoping rules (shadowing and block-local).
class Polygon
  # Initialize with keyword arg `side`; convert to Float to validate input early.
  # Float(side) will raise if side is not numeric → fail fast.
  def initialize(side:) ; @side = Float(side) ; end

  # Instance method with side effect: prints a message, returns nil.
  def draw ; puts "Drawing a polygon of side #{@side}" ; end
end

poly = Polygon.new(side: 4)                    # create Polygon with side = 4.0

# Reuse sum of squares pattern
sum = 0
[2, 3, 4, 5].each do |value|
  square = value * value                       # local variable `square` in block
  sum += square                                # accumulate squares
end
puts sum                                       # => 54

# Exception handling demo
begin
  poly.draw                                    # call method; works
rescue NoMethodError => e                      # would catch if method missing
  puts ">>> Error : #{e.class} - #{e.message}" # print error info
  puts e.backtrace.first                       # show first line of backtrace
end

# Shadowing example
thing = "outer label"
[1, 2].each { |thing| puts thing }             # block param `thing` shadows outer → prints 1,2
puts thing                                     # outer `thing` is intact → "outer label"

# Block-local variables with semicolon
name = "kept outside"
sum = 0
[2, 3, 4, 5].each do |value; name|             # `name` here is block-local, shadows outer `name`
  name = value * value                         # block-local assignment
  sum += name 
end
puts sum                                       # => 54
puts name                                      # outer "kept outside" still unchanged

# Numbered block parameters (Ruby 2.7+)
[9, 10].each { puts _1 }                       # => 9, 10

# =========================================
# 18) Yield & custom iterators
# =========================================
# Purpose: demonstrate yielding to blocks, custom iterators, and reimplementations.

# Method yielding exactly twice
def repeat_twice
  yield                                                     # yield control to caller
  yield
end
repeat_twice { puts "Hi there" }                            # prints "Hi there" twice

# Fibonacci sequence up to limit
def fib_until(limit)
  a, b = 1, 1                                               # start with 1, 1
  while a <= limit
    yield a                                                 # yield current term
    a, b = b, a + b                                         # advance tuple
  end
end

p fib_until(800) { |n| print n, " " }                       # explicit parameter
p fib_until(800) { print _1, " " }                          # numbered parameter

# Simple traversal
[2, 4, 6, 8, 10].each { |n| puts n }                        # built-in Array#each

# Add a custom Array method: detect_first
class Array
  def detect_first
    each do |value|
      return value if yield(value)                          # return first value matching condition
    end
    nil                                                     # return nil if none match
  end
end

puts [2, 4, 6, 8, 10].detect_first { |num| num * num > 50 } # => 8
puts [2, 4, 6, 8, 10].detect_first { _1 * _1 > 60 }         # => 10

# Map demonstrations with String#succ
p %w[R U B Y].map { |ch| ch.succ }                          # => ["S", "V", "C", "Z"]
p %w[R U B Y].map { _1.succ }                               # same using numbered params

# Educational reimplementation of map
class Array
  def map_edu
    out = []                                                # buffer for results
    each do |value|
      out << yield(value)                                   # push transformed element
    end
    out                                                     # return new array
  end
end

p [3, 5, 7].map_edu { |n| n * 2 }                           # => [6, 10, 14]

# =========================================
# 19) File iteration (read lines)
# =========================================
# Purpose: safe file reading with blocks; ensures file is closed automatically.

path = File.join(__dir__, "testfile.txt")      # path to file relative to script
File.open(path) do |file_handle|               # open file and pass handle to block
  file_handle.each do |row|                    # iterate each line lazily
    puts "Read: #{row}"                        # print line with newline
  end                                          # file auto-closes here
end

# Reopen and iterate with index
path = File.join(__dir__, "testfile.txt")
File.open(path) do |file_handle|
  file_handle.each.with_index do |row, lineno| # add index to each line
    puts "Line #{lineno}: #{row}"              # print line number + content
  end
end

# =========================================
# 20) Reduce with changed datasets
# =========================================
# Purpose: show reduce/inject for sum/product with/without initial value.

p [2, 4, 6, 8].reduce(0) { |sum, element| sum + element }         # start sum at 0
p [2, 4, 6, 8].reduce(0) { _1 + _2 }                              # shorthand with numbered params
p [2, 4, 6, 8].reduce(1) { |product, element| product * element } # start product at 1
p [2, 4, 6, 8].reduce(1) { _1 * _2 }                              # shorthand

p [2, 4, 6, 8].reduce { |sum, element| sum + element }            # no init → first elem is seed
p [2, 4, 6, 8].reduce { _1 + _2 }                                 # shorthand
p [2, 4, 6, 8].reduce { |product, element| product * element }
p [2, 4, 6, 8].reduce { _1 * _2 }

p [2, 4, 6, 8].reduce(:+)                                         # symbol form calls :+ on accumulator
p [2, 4, 6, 8].reduce(:*)                                         # symbol form for product
p [2, 4, 6, 8].sum                                                # optimized shorthand
p [2, 4, 6, 8].product([3, 5, 7])                                 # Cartesian product with array [3,5,7]

# =========================================
# 21) Ensuring closure with ensure + custom file helpers
# =========================================
# Purpose: show robust resource management patterns.
# - open_and_process wraps File.open and guarantees close via `ensure`, even on exceptions.
# - my_open mirrors File.open’s block form: returns the file when no block is given;
#   yields and auto-closes when a block is given.
# NOTE: Monkey-patching core classes (like File) is fine for learning, but avoid in production
#       libraries unless namespaced to prevent surprises.

class File
  def self.open_and_process(*args)         # define a class method that wraps File.open
    f = File.open(*args)                   # open the file with given args (e.g., path, mode)
    begin                                  # begin a protected section
      yield f                              # yield the file handle to the caller’s block
    ensure                                 # ensure runs whether or not an exception occurs
      f.close                              # always close the file handle
    end
  end
end

path = File.join(__dir__, "testfile.txt")  # construct path relative to this script’s directory
File.open_and_process(path, "r") do |file| # call the helper with read mode
  while (line = file.gets)                 # read next line; nil at EOF stops the loop
    puts line                              # print the line as-is (includes trailing newline)
  end
end

class File
  def self.my_open(* args)                 # another wrapper that mimics File.open behavior
    file = File.new(* args)                # create a new File handle
    return file unless block_given?        # if no block provided, return the handle to caller
    result = yield file                    # otherwise, yield handle to the provided block
    file.close                             # close after the block finishes (even if it returns)
    result                                 # return the block’s result to the caller
  end
end

path = File.join(__dir__, "testfile.txt")  # same path as above
File.my_open(path, "r") do |f|             # use our custom my_open with a block
  f.each_line do |line|                    # iterate over each line lazily
    puts "line read: #{line}"              # print with a label for clarity
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
  def store_block(&action)                            # capture the given block as a Proc in `action`
    @callback = action                                # save Proc in an instance variable
  end

  # Invoke the stored callback with a single argument.
  def call_with(arg)                                  # method to trigger the stored callback
    @callback.call(arg)                               # call the Proc with the provided argument
  end
end

cb = CallbackDemo.new # create a new demo object
cb.store_block { |param| puts "Arg: #{param}" }       # store a simple printing block
cb.call_with(123)                                     # => prints "Arg: 123"

# Turn an implicit block into an explicit Proc value and return it.
def capture_block(&blk)                               # &blk converts the block to a Proc
  blk                                                 # return the Proc object
end

# Example: get a Proc back and call it multiple times.
fn = capture_block { |x| puts "You passed: #{x}" }    # assign returned Proc to fn
fn.call(111)                                          # => "You passed: 111"
fn.call("kiwi")                                       # => "You passed: kiwi"

# Lambdas are Procs with strict arity and `return` only exits the lambda itself.
fn = ->(x) { puts "Lambda says: #{x}" }               # arrow lambda syntax with one parameter
fn.call(222)                                          # => "Lambda says: 222"
fn.call("mango")                                      # => "Lambda says: mango"
 
fn = lambda { |x| puts "Lambda (long) says: #{x}" }   # long-form lambda
fn.call(333)                                          # => "Lambda (long) says: 333"
fn.call "papaya"                                      # parentheses optional in Ruby

# Plain `proc` and `Proc.new` are equivalent constructors for lenient-arity Procs.
# (They accept missing extra args as nil, and extra args are ignored.)
fn = proc { |x| puts "proc says: #{x}" }              # create a Proc with lenient arity
fn.call(444)                                          # => "proc says: 444"
fn.call("guava")                                      # => "proc says: guava"

fn = Proc.new { |x| puts "Proc.new says: #{x}" }      # equivalent to proc
fn.call(555)                                          # => "Proc.new says: 555"
fn.call("fig")                                        # => "Proc.new says: fig"

# Closure that remembers captured variables.
# The returned lambda multiplies its argument by `seed` captured from the outer scope.
def make_multiplier(seed)                             # outer variable `seed` will be captured
  ->(n) { seed * n }                                  # return a lambda that uses `seed`
end
m1 = make_multiplier(17)                              # capture seed = 17
puts m1.call(3)                                       # => 51
puts m1.call(4)                                       # => 68 
m2 = make_multiplier("Yo ")                           # capture a String as seed
puts m2.call(3)                                       # => "Yo Yo Yo " (String#* repeats)

# Stateful closure: `acc` persists between calls because it is captured by the lambda.
def doubling_factory                                  # define a factory that builds a stateful lambda
  acc = 2                                             # local state to capture
  -> { acc += acc }                                   # closure: updates and returns `acc` on each call
end

doubler = doubling_factory # get a new closure with its own state
puts doubler.call                                     # => 4
puts doubler.call                                     # => 8
puts doubler.call                                     # => 16

# Lambdas with different arities (number of required parameters).
# NOTE: Lambdas enforce arity; using fewer/more args raises ArgumentError unless you use *rest.
lam1 = -> a { puts "In lam1 with #{a}" }              # one required parameter (no parens style)
lam2 = -> x, y { puts "In lam2 with #{x} and #{y}" }  # two required parameters
lam3 = ->(x, y) { puts "In lam3 with #{x} and #{y}" } # same with parentheses

puts lam1.call "alpha"                                # call with one arg
puts lam2.call "beta", "citrus"                       # call with two args
puts lam3.call "date", "elderberry"                   # call with two args

# =========================================
# 23) Functional control structures using callables
# =========================================
# Purpose: show how to encode control flow by passing behavior (Procs/lambdas) as data.

# Branching by calling the appropriate callable based on a condition.
def branch_if(condition, then_clause, else_clause) # condition is boolean, others are callables
  if condition                                     # choose path based on condition
    then_clause.call                               # execute "then" branch
  else
    else_clause.call                               # execute "else" branch
  end
end

5.times do |val|                                   # repeat for values 0..4
  branch_if(                                       # dispatch to one of two lambdas
    val < 2,                                       # condition: small if < 2
    -> { puts "#{val} is small" },                 # then branch behavior
    -> { puts "#{val} is big" }                    # else branch behavior
  )
end

# While-like loop driven by a predicate callable.
def loop_while(cond, &body)                        # cond must respond to #call and return truthy/falsey
  while cond.call                                  # evaluate condition each iteration
    body.call                                      # invoke the body Proc
  end
end

counter = 0                                        # initialize loop state
loop_while(-> { counter < 3 }) do                  # predicate: continue while counter < 3
  puts counter                                     # side effect: print current counter
  counter += 1                                     # update state
end

# Variadic lambda examples: collect remaining args with *rest and optionally a &block.
# NOTE: In lambdas, arity still applies to the required parameters (before *rest).
varargs1 = lambda do |a, *rest, &block|            # lambda with one required arg, rest, and block
  puts "a = #{a.inspect}"                          # show first arg
  puts "rest = #{rest.inspect}"                    # show remaining args as array
  block.call                                       # execute the provided block
end
varargs1.call(1, 2, 3, 4) { puts "in block1" }     # => prints a/rest, then runs block

varargs2 = ->(a, *rest, &block) do                 # arrow lambda with same signature
  puts "a = #{a.inspect} "                         # show first arg
  puts "rest = #{rest.inspect} "                   # show remaining args
  block.call                                       # execute block
end
varargs2.call(5, 6, 7, 8) { puts "in block2" }     # => prints a/rest, then runs block

# =========================================
# 24) Enumerators (external iteration), reverse_each, next
# =========================================
# Purpose: demonstrate creating external iterators with `to_enum` / `enum_for`,
#          consuming them with `next`, and using enumeration helpers.
# NOTE: Calling `next` past the end raises StopIteration.

arr = [99, "ruby", :ok] # sample array with mixed types
enum_arr = arr.to_enum  # build an external enumerator over arr
p enum_arr.next # => 99     (first element)
p enum_arr.next # => "ruby" (second element)

pairs = { sun: "star", earth: "planet" } # sample hash
enum_hash = pairs.to_enum # enumerator yields key-value pairs as 2-element arrays
p enum_hash.next # => [:sun, "star"]
p enum_hash.next # => [:earth, "planet"]

# Reverse traversal via reverse_each
enum_rev = arr.to_enum(:reverse_each) # enumerator that uses Array#reverse_each under the hood
p enum_rev.next # => :ok    (last element first)
p enum_rev.next # => "ruby" (then the previous element)

# `each` itself returns an Enumerator when called without a block
enum_each = arr.each # same as arr.to_enum(:each)
p enum_each.next # => 99
p enum_each.next # => "ruby"


# Two enumerators with different lengths; this loop will raise StopIteration
# when the shorter enumerator runs out. This is intentional for demonstration.
short_enum = [10, 20, 30].to_enum                                            # 3 elements
long_enum  = ("A".."Z").to_enum                                              # many elements
loop do                                                                      # manual external-iteration loop
  puts "#{short_enum.next} - #{long_enum.next}"                              # advance both; StopIteration stops the loop
end

# Build arrays of [value, index] pairs using each_with_index / with_index.
result = []                                                                  # buffer for pairs
%w[red green blue].each_with_index { |item, index| result << [item, index] } # push [value, index]
p result                                                                     # => [["red",0],["green",1],["blue",2]]

result = []                                                                  # reset buffer
"ruby".each_char.each_with_index { |ch, index| result << [ch, index] }       # chain char iteration + index
p result                                                                     # => [["r",0],["u",1],["b",2],["y",3]]

result = [] # reset again
"ruby".each_char.with_index { |ch, index| result << [ch, index] }            # with_index variant
p result

# Map directly from the enumerator with with_index.
p "ruby".each_char.with_index.map { |ch, index| [ch, index] }                # build pairs via map

# Materialize a character enumerator to an array.
enum_chars = "ruby".each_char                                                # external enumerator over characters
p enum_chars.to_a                                                            # => ["r","u","b","y"]

# Create an enumerator for slicing a range into groups of 3.
enum_in_threes = (10..20).enum_for(:each_slice, 3)                           # enumerator over 3-sized slices
p enum_in_threes.to_a                                                        # => [[10,11,12],[13,14,15],[16,17,18],[19,20]]

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
tri_seq = Enumerator.new do |yielder|                   # yielder is used to emit values
  total = 0                                             # running sum
  step  = 1                                             # increment amount
  loop do                                               # infinite generator
    total += step                                       # accumulate
    step  += 1                                          # next step size
    yielder.yield(total)                                # emit the current triangular number
  end
end

# Consume five elements via repeated `next`.
5.times { print tri_seq.next, " " }                     # prints "1 3 6 10 15 "
puts                                                    # newline

# Produce a pair-evolving sequence using Enumerator.produce.
tri_pairs = Enumerator.produce([2, 3]) do |total, step| # state is [total, step]
  [total + step, step + 1]                              # next state
end
p tri_pairs.first(5).map { _1.first }                   # take first 5 states, project totals → [2,5,9,14,20]

# =========================================
# 26) Lazy streams + predicates
# =========================================
# Purpose: compose infinite sequences with lazy evaluation and filter them with predicates.
# Notes:
# - `.lazy` defers work until a terminal operation (e.g., `first(10)`).
# - Chaining `.select` is efficient with lazy enumerators because items are processed on demand.

class NaturalFlow
  # Infinite stream of natural numbers starting at 1.
  def stream
    Enumerator.produce(1) { |n| n + 1 }.lazy                         # lazy infinite sequence: 1,2,3,...
  end
end

# Take the first 10 naturals (forces only 10 computations).
p NaturalFlow.new.stream.first(10)                                   # => [1,2,3,4,5,6,7,8,9,10]

# Filter lazily: multiples of 4, then take first 10 matches.
p NaturalFlow.new.stream
  .select { (_1 % 4).zero? }                                         # keep numbers divisible by 4
  .first(10)                                                         # materialize first 10 results

# Palindrome predicate (string-based): e.g., 121 → "121" equals its reverse.
def palindromic?(n)
  s = n.to_s                                                         # convert to string
  s == s.reverse                                                     # compare to reversed string
end
# Compose filters: multiples of 4 that are also palindromic.
p NaturalFlow.new.stream
  .select { (_1 % 4).zero? }                                         # divisible by 4
  .select { palindromic?(_1) }                                       # and palindromic
  .first(10)                                                         # take first 10 such numbers

# Reuse intermediate pipelines: define once, refine later.
multiples_of_four = NaturalFlow.new.stream.select { (_1 % 4).zero? } # lazy pipeline
p multiples_of_four.first(10)                                        # peek at first 10 multiples of 4

mf_palindromes = multiples_of_four.select { palindromic?(_1) }       # refine further
p mf_palindromes.first(10)                                           # first 10 that also are palindromic

# Same idea using callable predicates (lambdas) and & to pass them as blocks.
multiple_of_four = -> n { (n % 4).zero? }                            # predicate: divisible by 4
is_palindrome = -> n { s = n.to_s; s == s.reverse }                  # predicate: palindrome
p NaturalFlow.new.stream
  .select(&multiple_of_four)                                         # pass lambda as block
  .select(&is_palindrome)                                            # pass lambda as block
  .first(10)                                                         # take first 10

# Another lazy stream based on a pair state, projected to the first component.
pair_growth = Enumerator.produce([2, 3]) do |sum, step|              # stateful generator
  [sum + step, step + 1]                                             # next state transition
end.lazy.map { _1.first }                                            # lazily map to the first component
p pair_growth.first(5)                                               # => [2, 5, 9, 14, 20]

