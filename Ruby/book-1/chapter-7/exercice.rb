# =========================================
# 1) Integer literals (decimal, hex, octal, binary, separators)
# =========================================
p 654321                  # simple decimal
p 0d654321                # explicit decimal prefix for decimal
p 654_321                 # underscores for readability in long numbers
p -987                    # negative integer literal
p 0xc0de                  # hexadecimal literal (0x prefix)
p 0o755                   # octal literal (0o prefix in Ruby)
p -0b1011_0001            # binary literal with underscores; negative value
p 987_654_321_987_654_321 # very large integer; underscores group digits

# =========================================
# 2) BigDecimal
# =========================================
require "bigdecimal"   # load BigDecimal for precise decimal math (money, etc.)
a = BigDecimal("2.71") # create a BigDecimal from string to avoid float rounding
b = BigDecimal("1.19") # another BigDecimal operand
p a + b                # precise decimal addition (=> 3.90)

# =========================================
# 3) Rationals
# =========================================
p 5/8             # Integer division => 0 (truncates toward zero)
p 5/8r            # Rational literal => (5/8)
p 0.625r          # Rational created from a float literal => (5/8)
p "5/8".to_r      # String to Rational => (5/8)
p Rational(5, 8)  # Construct Rational from numerator/denominator
p Rational("5/8") # Construct Rational from a string form

# =========================================
# 4) Complex
# =========================================
p 2 + 3i                 # Complex literal via 3i suffix → (2+3i)
p "2+3i".to_c            # Convert a String to Complex → (2+3i)
p Complex(2, 3)          # Construct Complex from real & imaginary parts
p Complex("2+3i")        # Construct Complex directly from a String

# =========================================
# 5) Simple loop over “lines” (numbers here)
# =========================================
buffer = [11, 22, 33]               # Pretend “lines” of input; using integers for simplicity
buffer.each { |n| print n }         # Print each element without newline
puts "\n"                           # Print a newline (explicitly)

buffer = [11, 22, 33]               # Reset sample data
buffer.each do |n|                  # Iterate over each number
  digits = n.to_s.chars.map(&:to_i) # Convert to String, split into chars, map to Integers
  print digits.sum, " "             # Print the sum of its digits followed by a space
end
puts                                # Terminate line with a newline

# =========================================
# 6) Numeric promotion rules (Integer/Float/Rational/Complex)
# =========================================
p 2 + 3        # Integer + Integer → Integer (5)
p 2 + 3.0      # Integer + Float → Float (5.0)
p 2.0 + 3      # Float + Integer → Float (5.0)
p 1.0 + 2 + 3i # Float + Integer + Complex → Complex (promotes to Complex)
p 1 + 3/5r     # Integer + Rational → Rational (1 + 3/5 = 8/5)
p 1.0 + 3/5r   # Float + Rational → Float (1.6)

# =========================================
# 7) Division variants
# =========================================
p 1.0 / 2     # Float ÷ Integer → Float (0.5)
p 1 / 2.0     # Integer ÷ Float → Float (0.5)
p 1/2         # Integer ÷ Integer → Integer division (0)
p 1.to_f / 2  # Explicit conversion to Float → 0.5
p 1 * 1.0 / 2 # Promote by multiplying with Float, then divide → 0.5
p 1.fdiv(2)   # Float division method, ignores integer truncation → 0.5

# =========================================
# 8) Integer iterators
# =========================================
3.times { print "Z " }                # repeat block 3 times → "Z Z Z "
1.upto(5) { |i| print i, " " }        # count upward from 1 to 5
42.downto(38) { |i| print i, " " }    # count downward 42 → 38
10.step(30, 5) { |i| print i, " " }   # step from 10 to 30 in increments of 5
puts                                  # newline after prints

# Add index while iterating backward
10.downto(7).with_index do |num, idx|
  puts "#{idx}: #{num}"               # show iteration index with number
end

# =========================================
# 9) String syntax & interpolation
# =========================================
puts 'escape using "\"'                                # backslash preserved in single quotes
puts 'that\'s correct'                                 # escape apostrophe
puts "Seconds/day: #{24 * 60 * 60}"                    # interpolate expression inside string
puts "#{"Ha!" * 3} Happy Holidays!"                    # interpolate repeated string → "Ha!Ha!Ha! Happy Holidays!"
puts "The input file name is #$FILENAME"               # interpolates global var $FILENAME (nil if unset)

# Embedded method inside interpolation
puts "now is #{
  def the(x)                                           # define helper method
    'the' + x                                          # concatenate "the" with argument
  end
  the('moment')                                        # call helper, returns "themoment"
} for all brave coders..."                             # full sentence

puts "this" "is" "just" "one" "string"                 # adjacent string literals auto-concatenate
puts %q/general single-quoted string/                  # %q = single-quoted string (no interpolation)
puts %Q!general double-quoted string!                  # %Q = double-quoted string (interpolation enabled)
puts %Q{Seconds/day: #{24 * 60 * 60}}                  # curly braces as delimiters, with interpolation

# Heredoc (basic)
block_text = <<END_OF_STRING
  The body of the string spans multiple lines
  until a line begins with END_OF_STRING.
END_OF_STRING
puts block_text                                        # print heredoc content

# Indented heredoc with squiggly (<<~)
def lyric
  <<~TXT
    Swifter than a comet’s tail,
    stronger than a winter gale,
    over rooftops in a single bound—
    look! up there! a hero found!
  TXT
end
puts lyric                                             # call method → prints indented block

# Multiple heredocs passed to print
print <<-PART1, <<-PART2
Con
PART1
cat
PART2

# Encoding probe
word = "otter"                                         # sample string
puts "Encoding of #{word.inspect} is #{word.encoding}" # show encoding (UTF-8 default)

# =========================================
# 10) Small value object + parsing lines
# =========================================
class Track
  attr_reader :title, :artist, :length                              # read-only accessors

  # Constructor: takes title, artist name, and track length
  def initialize(title, artist, length)
    @title  = title
    @artist = artist
    @length = length
  end

  # String representation (overridden to_s)
  def to_s = "#{@title} - #{@artist} #{@length}"
end

# Sample catalog data in heredoc format (multi-line string)
catalog = <<~TRACKS
  file01.mp3 | 2:47 | Horizon | Crimson Skies
  file02.mp3 | 5:12 | Solaris | Electric Pulse
  file03.mp3 | 3:03 | Neonix  | Midnight Drive
TRACKS

# --- First parsing: keep length as "M:SS" string ---
playlist = catalog.lines.map do |line|
  _file, len, artist, title = line.chomp.split(/\s*\|\s*/)          # split row by |
  Track.new(title, artist.squeeze(" "), len)                        # construct Track
end
p playlist[1]                                                       # second element

# --- Second parsing: convert length into seconds (integer) ---
playlist = catalog.lines.map do |line|
  _file, len, artist, title = line.chomp.split(/\s*\|\s*/)          # split row by |
  mins, secs = len.scan(/\d+/)                                      # extract numbers
  Track.new(title, artist.squeeze(" "), mins.to_i * 60 + secs.to_i)
end
p playlist[1]

# =========================================
# 11) Ranges & slicing
# =========================================
p (1..10).to_a                # inclusive integer range → array [1..10]
p ("a".."z").to_a             # string range → ["a", "b", ..., "z"]
p (0...3).to_a                # exclusive upper bound → [0,1,2]

# String ranges work lexicographically
p ("cat".."caz").to_a
enum = ("cat".."caz").to_enum # external enumerator
p enum.next                   # first element "cat"
p enum.next                   # second element "cau"

nums = [1, 2, 3, 4, 5, 6]
p nums[..2]                   # slice from index 0 to 2 → [1,2,3]
p nums[2..]                   # slice from index 2 to end → [3,4,5,6]

digits = 0..9
digits.include?(5)            # true if 5 in range (not printed)
digits.max                    # => 9
digits.reject { |i| i < 5 }   # => [5,6,7,8,9]
digits.reduce(:+)             # => 45 (sum of 0..9)

# =========================================
# 12) Custom range endpoints with succ and <=>
# =========================================
class Doubling
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def <=>(other)
    @value <=> other.value    # define ordering comparison
  end

  def succ
    Doubling.new(@value * 2)  # successor doubles the value
  end

  def to_s
    @value.to_s               # string representation
  end
end

d1 = Doubling.new(4)          # starting point (4)
d2 = Doubling.new(64)         # end point (64)
puts (d1..d2).to_a.join(", ") # expand range using custom succ

# =========================================
# 13) Range membership & cover/include
# =========================================
p (1..10) === 5             # true: 5 lies within the range
p (1..10) === 15            # false: 15 is outside
p (1..10) === 3.14159       # true: floats can be checked too

p ("a".."j") === "c"        # true: "c" between a and j
p ("a".."j") === "z"        # false: outside of the end bound

p ("a".."j").include?("c")  # true: actual element "c" is in the sequence
p ("a".."j").include?("bb") # false: "bb" is not a generated element
p ("a".."j").cover?("bb")   # true: "bb" lies lexically between "a" and "j"

# NOTE:
# - include? checks if a value is one of the produced elements (iteration-based).
# - cover? checks only whether the value falls between the endpoints (bounds-based).
#   → cover? is faster but may return true for values that iteration wouldn't produce.

# =========================================
# 14) case with ranges (exclusive vs inclusive)
# =========================================
vehicle_age = 9.5           # numeric value representing "age" of a vehicle

# --- Using exclusive ranges (`...` excludes the end) ---
case vehicle_age
when 0...1
  puts "Fresh off the lot"        # less than 1 year
when 1...3
  puts "Quite new"                # between 1 and just under 3 years
when 3...10
  puts "Seasoned but trustworthy" # 3 ≤ age < 10
when 10...30
  puts "Well-worn"                # 10 ≤ age < 30
else
  puts "Classic collectible"      # everything else
end

# --- Using inclusive ranges (`..` includes the end) ---
case vehicle_age
when 0..0
  puts "Fresh off the lot"        # exactly 0 years old
when 1..2
  puts "Quite new"                # 1 ≤ age ≤ 2
when 3..9
  puts "Seasoned but trustworthy" # 3 ≤ age ≤ 9
when 10..29
  puts "Well-worn"                # 10 ≤ age ≤ 29
else
  puts "Classic collectible"      # all other cases
end