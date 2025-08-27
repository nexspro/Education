# =========================================
# 1) String and number basics
# =========================================
# Notes:
# - `length` returns the character count (UTF-8 aware in modern Ruby).
# - `index(substring)` returns the position of the first match, or nil if absent.
# - `even?` / `odd?` are predicate methods that return true/false.
puts "Stellar Lynx".length # => 12 prints the number of characters in the string
puts "apollo".index("a")   # => 0 prints the index of the first "a" (0-based); nil if no match
puts 84.even?              # => true prints whether 84 is an even integer

# =========================================
# 2) Simple OOP example
# =========================================
# Notes:
# - `attr_reader :title` auto-generates a getter so we can call `tune.title`.
# - Keep constructors tiny; store only what you truly need.
# - Interpolation (#{...}) reads better than concatenation for messages.
class Tune                            # define a class to represent a music track
  attr_reader :title                  # create a public getter so external code can read @title
  def initialize(title)               # constructor runs when calling Tune.new(...)
    @title = title                    # save the provided title into an instance variable
  end                                 # end of constructor
end                                   # end of Tune class
class Deck                            # define another class responsible for "playing" tunes
  def spin(tune)                      # instance method expecting a Tune object
    "Spinning track: #{tune.title}"   # build and return a user-facing message using interpolation
  end                                 # end of spin
end                                   # end of Deck class
track1 = Tune.new("Whispers in Rain") # create a Tune instance with a specific title
track2 = Tune.new("Shadows of Light") # create another Tune instance with a different title
deck = Deck.new                   # create a Deck instance that can "spin" tunes
puts deck.spin(track1)              # => "Spinning track: Whispers in Rain" call spin and print the returned message
puts deck.spin(track2)              # => "Spinning track: Shadows of Light" same, for the second tune

# =========================================
# 3) Integer operations (absolute value)
# =========================================
# Notes:
# - .abs converts a negative number into its positive magnitude.
number = -932               # assign a negative integer to a variable
absolute_value = number.abs # compute the absolute value (drops the sign)
puts absolute_value         # => 932 print the result of the absolute value computation

# =========================================
# 4) String methods and interpolation
# =========================================
# Notes:
# - String concatenation (`+`) combines two strings explicitly.
# - String interpolation (`#{...}`) is usually cleaner and avoids type errors.
# - `.capitalize` returns a copy of the string with the first character in uppercase.
def farewell_message(name)                           # define a method that builds a string using concatenation
  phrase = "Farewell, " + name + ", until next time" # concatenate three parts into one string
  return phrase                                      # return the result explicitly (last expression would also work)
end
puts farewell_message("Alice")                       # => "Farewell, Alice, until next time"
puts farewell_message("Bob")                         # => "Farewell, Bob, until next time"

# Escape sequence \n inserts a line break inside a string.
puts "Hello and goodbye to you,\nCharlie"            # prints two lines: "Hello and goodbye to you," then "Charlie"

def hello_goodbye(name)                              # define a method using interpolation for cleaner syntax
  "See you soon, #{name}, and hello again"           # embed the variable directly in the string
end
puts hello_goodbye("Diana")                          # => "See you soon, Diana, and hello again"

def formatted_goodbye(name)                          # define a method that formats the name properly
  "Goodbye, #{name.capitalize}, until we meet again" # capitalize ensures first letter is uppercase
end
puts formatted_goodbye("edward")                     # => "Goodbye, Edward, until we meet again"
puts formatted_goodbye("frank")                      # => "Goodbye, Frank, until we meet again"

# =========================================
# 5) Arrays
# =========================================
# Notes:
# - Arrays can contain different object types in Ruby.
# - Access elements by index starting at 0.
# - Setting an element to nil empties the slot but does not remove it.
# - Array#inspect shows a programmer-readable representation.
arr = [42, "cat", 5.67]                # create an array with an integer, a string, and a float
puts "The first element is #{arr[0]}"  # => 42 (index 0 is the first element)
arr[2] = nil                           # replace the element at index 2 with nil
puts "The array is now #{arr.inspect}" # => [42, "cat", nil] (shows contents including nil)

# =========================================
# 6) Hashes
# =========================================
# Notes:
# - Hashes map keys to values.
# - Keys can be Strings or Symbols.
# - Accessing a missing key returns nil by default (no error).
instrument_family = {                                             # define a hash with string keys
  "guitar" => "string",                                           # map "guitar" to "string"
  "flute" => "woodwind",                                          # map "flute" to "woodwind"
  "drums" => "percussion",                                        # map "drums" to "percussion"
  "trumpet" => "brass",                                           # map "trumpet" to "brass"
  "violin" => "string"                                            # map "violin" to "string"
}
puts instrument_family["flute"]                                   # => "woodwind" (key exists in hash)
puts instrument_family["guitar"]                                  # => "string"   (key exists in hash)
puts instrument_family["saxophone"]                               # => nil        (key not found)

# Histogram with default values
counter = Hash.new(0)                                             # create a hash where missing keys default to 0
puts counter["ruby"]                                              # => 0 (key not present, default returned)
counter["ruby"] += 1                                              # increment the value associated with "ruby"
puts counter["ruby"]                                              # => 1 (key now exists with value 1)

# Symbols as keys
instrument_family = {                                             # define a hash using symbols as keys
  cello: "string",                                                # :cello is a symbol
  clarinet: "woodwind",                                           # :clarinet maps to "woodwind"
  drum: "percussion"                                              # :drum maps to "percussion"
}
puts instrument_family[:cello]                                    # => "string" (accessing by symbol key)
puts "A clarinet is a #{instrument_family[:clarinet]} instrument" # => "A clarinet is a woodwind instrument"

# =========================================
# 7) Time and conditionals
# =========================================
# Notes:
# - Time.now returns the current system time (date + hour).
# - Methods like saturday? and sunday? check the day of week and return true/false.
today = Time.now            # get the current time object
if today.saturday?          # check if current day is Saturday
  puts "House chores today" # run this branch if true
elsif today.sunday?         # otherwise, check if it's Sunday
  puts "Take some rest"     # run this branch if true
else                        # if neither Saturday nor Sunday
  puts "Workday ahead"      # default branch: treat as a workday
end

# =========================================
# 8) While loop with conditions
# =========================================
# Notes:
# - Loops until both conditions are satisfied (weight < 100 and pallets <= 5).
# - Each pallet weight is generated randomly within a range.
class Box
  attr_reader :weight                # create a getter for @weight
  def initialize(weight)             # constructor: called when creating a Box
    @weight = weight                 # save the given weight
  end

  def self.next_pallet               # class method to generate a new Box with random weight
    Box.new(rand(10..30))            # random weight between 10 and 30
  end
end
pallets = 0                          # counter for number of pallets
weight = 0                           # accumulator for total weight
while weight < 100  && pallets <= 5  # loop until total weight >= 100 OR more than 5 pallets
 box = Box.next_pallet               # generate a new Box
 puts "new pallet: #{box.weight} kg" # print its weight
 weight += box.weight                # add this weight to total
 pallets += 1                        # increment pallet counter
end
puts "Total weight: #{weight} kg"    # after loop, print accumulated weight
puts "Total pallets: #{pallets}"     # print how many pallets were generated

# =========================================
# 9) Processing an array of strings
# =========================================
# Notes:
# - Iterates manually using while loop and index.
# - String#downcase converts all letters to lowercase.
# - Useful for text normalization before further processing.
lines = [               # define an array of strings to process
  "HELLO World",        # string with mixed case
  "   Ruby Is GREAT  ", # string with leading/trailing spaces
  "Rust language"       # string already in lowercase form
]
i = 0                   # initialize index counter
while i < lines.size    # loop until index reaches array length
  line = lines[i]       # get current string from array
  puts line.downcase    # print the string in all lowercase
  i += 1                # increment index for next iteration
end

# =========================================
# 10) Conditional inline syntax
# =========================================
# Notes:
# - Inline `if` is concise, but use sparingly for readability.
radiation = 3200                             # assign an integer value to represent radiation level
if radiation > 3000                          # check if value exceeds threshold
  puts "High radiation warning!"             # print warning if condition is true
end
puts "Critical warning!" if radiation > 3000 # inline if: same condition in a shorter form

# =========================================
# 11) Loop examples
# =========================================
# Notes:
# - Loop multiplies a number by itself until it exceeds 1000.
value = 3                         # start with a small integer
while value < 1000                # continue looping while value is less than 1000
  value *= value                  # multiply value by itself (exponential growth)
end
puts value                        # print the final result once loop ends

# One-line version
value = 3                         # reset initial value
value *= value while value < 1000 # compact loop syntax: execute until condition fails
puts value                        # print result (same as multi-line loop)

# =========================================
# 12) Regex examples
# =========================================
# Notes:
# - /pattern/ defines a regular expression.
# - `|` means OR (alternation).
# - `\w` matches word characters (letters, digits, underscore).
# - `( )` groups parts of the pattern.
/Go|Rust/                                                            # regex matching "Go" or "Rust"
/\w+@\w+\.\w+/                                                       # regex for a simple email-like pattern
/Ruby.*Python/                                                       # regex: "Ruby" followed by anything, then "Python"
/Java(Script|Ruby)/                                                  # regex: "JavaScript" or "JavaRuby" 

line = "Rust"                                                        # assign a string to variable
puts "Language found: #{line}" if line =~ /\b(Ruby|Rust)\b/          # `=~` returns index of match or nil; condition passes if not nil

line = "Ruby"                                                        # assign another string
puts "Language mentioned: #{line}" if line.match?(/\b(Ruby|Rust)\b/) # `match?` returns true/false directly

line = "I like Python and JavaScript"                                # string containing two language names
puts line.sub(/Python/, "Ruby")                                      # => replaces first "Python" with "Ruby"
puts line.gsub(/JavaScript|Python/, "Ruby")                          # => replaces all matches ("JavaScript" and "Python") with "Ruby"

# =========================================
# 13) Iterators and blocks
# =========================================
# Notes:
# - Arrays can be traversed with iterators.
# - Blocks can be written inline `{ ... }` or multi-line `do ... end`.
# - Block parameters shadow outer variables of the same name.
member = "Alice"                       # define a variable with a string
item = [member]                        # create an array containing the variable
item.each { puts "Hello"}              # iterate array; block prints "Hello" once for each element
item.each do |member|                  # iterate array with a block argument (named member here)
  puts "Enroll #{member} dans le club" # use block variable inside string interpolation
  puts "#{member} socialise"           # print another message using block variable
end

# =========================================
# 14) Custom method with yield
# =========================================
# Notes:
# - `yield` executes the block provided when calling the method.
# - It can be invoked multiple times inside the method.
def demo_block
  puts "Start"                         # print a starting message
  yield                                # execute the block passed to demo_block
  yield                                # execute the same block again
  puts "Finish"                        # print an ending message
end
demo_block { puts "Inside the block" } # block is executed twice, so output shows "Inside the block" two times


# =========================================
# 15) Yield with parameters
# =========================================
# Notes:
# - Methods can pass arguments to the block.
# - The block must declare parameters to receive these values.
def say_something
  yield("Mike", "hello")                                     # call the block with two arguments
  yield("Sara", "goodbye")                                   # call the block again with other values
end
say_something { |person, msg| puts "#{person} says #{msg}" } # => prints "Mike says hello" then "Sara says goodbye"

# =========================================
# 16) Iterators
# =========================================
# Notes:
# - Built-in iteration methods simplify looping in Ruby.
# - each, times, upto, and ranges all provide clear iteration patterns.
animals = ["ant", "bee", "cat", "dog"]
animals.each { |a| puts a }                      # prints each animal on its own line
["cat", "dog", "horse"].each { |n| print n, " "} # prints "cat dog horse " all on the same line
5.times { print "*" }                            # repeats the block 5 times => "*****"
3.upto(6) { |i| print i}                         # counts upward from 3 to 6 => "3456"
( "a".."e" ).each { |ch| print ch }              # iterates over range of letters => "abcde"
( "a".."e" ).each { print _1 }                   # same as above, uses numbered block param (_1) => "abcde"

# =========================================
# 17) Command-line arguments
# =========================================
# Notes:
# - ARGV is a built-in array containing arguments passed when running the script.
# - ARGV.size returns how many arguments were provided.
puts "You passed #{ARGV.size} arguments" # prints the count of CLI arguments
p ARGV                                   # prints the array of arguments itself