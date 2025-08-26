# Basic string and number methods
puts "The fox".length # Returns the number of characters
puts "marco".index("m") # Returns the index of 'm'
puts 42.even? # Check if 42 is even

# Example method calls
class Song
  attr_reader :title
  def initialize(title)
    @title = title
  end
end
class Player 
  def play(song)
    "Playing song: #{song.title}"
  end
end
track1 = Song.new("Sky of Dreams")
track2 = Song.new("Echoes of Tomorrow")
player = Player.new
puts player.play(track1)
puts player.play(track2)

# Working with integers
number = -4567
absolute_value = number.abs # Converts to positive
puts absolute_value

# Define a method that builds a farewell message
def farewell_message(name)
  phrase = "No idea why you say goodbye, " + name + ", but I say hello"
  return phrase
end
puts farewell_message("Alice")
puts farewell_message("Bob")

# Print with a line break inside the string
puts "Hello and goodbye to you,\nCharlie"

# Improved method using string interpolation
def hello_goodbye(name)
  "No idea why you say goodbye, #{name}, but I say hello"
end
puts hello_goodbye("Diana")

# Capitalize the name for better formatting
def formatted_goodbye(name)
  "No idea why you say goodbye, #{name.capitalize}, but I say hello"
end
puts formatted_goodbye("edward")
puts formatted_goodbye("frank")

# Arrays
arr = [1, "dog", 3.14]
puts "The first element is #{arr[0]}"
arr[2] = nil
puts "The array is now #{arr.inspect}"

# Hash with strings as keys
instrument_family = {
  "guitar" => "string",
  "flute" => "woodwind",
  "drums" => "percussion",
  "trumpet" => "brass",
  "violin" => "string"
}
puts instrument_family["flute"]     # "woodwind"
puts instrument_family["guitar"]    # "string"
puts instrument_family["saxophone"] # nil

# Histogram with default values
counter = Hash.new(0)
puts counter["ruby"]  #0
counter["ruby"] += 1
puts counter["ruby"]  #1

# Symbols as keys
instrument_family = {
  cello: "string",
  clarinet: "woodwind",
  drum: "percussion"
}
puts instrument_family[:cello]
puts "A clarinet is a #{instrument_family[:clarinet]} instrument"

# Time and conditionals
today = Time.now
if today.saturday?
  puts "House chores today"
elsif today.sunday?
  puts "Take some rest"
else
  puts "Workday ahead"
end

# While loop example with conditions
class Box
  attr_reader :weight
  def initialize(weight)
    @weight = weight
  end

  def self.next_pallet
    Box.new(rand(10..30))
  end
end
pallets = 0
weight = 0
while weight < 100  && pallets <= 5
 box = Box.next_pallet # Assume method exists
 puts "new pallet: #{box.weight} kg"
 weight += box.weight
 pallets += 1
end
puts "Total weight: #{weight} kg"
puts "Total pallets: #{pallets}"

# Read from console and process
lines = [
  "HELLO World",
  "   Ruby Is GREAT  ",
  "Rust language"
]
i = 0
while i < lines.size
  line = lines[i]
  puts line.downcase
  i += 1
end

# Conditional inline syntax
radiation = 3500
if radiation > 3000
  puts "High radiation warning!"
end
puts "Critical warning!" if radiation > 3000

# Loop examples
value = 4
while value < 1000
  value *= value
end
puts value

# One-line version
value = 4
value *= value while value < 1000
puts value

# Regex examples
/Go|Rust/
/\w+@\w+\.\w+/
/Ruby.*Python/
/Java(Script|Ruby)/

# First test
line = "Rust"
puts "Language found: #{line}" if line =~ /\b(Ruby|Rust)\b/

# Second test
line = "Ruby"
puts "Language mentioned: #{line}" if line.match?(/\b(Ruby|Rust)\b/)

# Substitution examples
line = "I like Python and JavaScript"
puts line.sub(/Python/, "Ruby")
puts line.gsub(/JavaScript|Python/, "Ruby")

# Iterators and blocks
member = "Alice"
item = [member]
item.each { puts "Hello"}
item.each do |member|
  puts "Enroll #{member} dans le club"
  puts "#{member} socialise"
end

# Custom method with yield
def demo_block
  puts "Start"
  yield
  yield
  puts "Finish"
end
demo_block { puts "Inside the block" }

# Yield with parameters
def say_something
  yield("Mike", "hello")
  yield("Sara", "goodbye")
end
say_something { |person, msg| puts "#{person} says #{msg}" }

# Iterators
animals = ["ant", "bee", "cat", "dog"]
animals.each { |a| puts a }
["cat", "dog", "horse"].each { |n| print n, " "}
5.times { print "*" }
3.upto(6) { |i| print i}
( "a".."e" ).each { |ch| print ch }
( "a".."e" ).each { print _1 }

# Command-line arguments
puts "You passed #{ARGV.size} arguments"
p ARGV