# Create new Song objects with different titles
track1 = Song.new("Sky of Dreams")
track2 = Song.new("Echoes of Tomorrow")

# Basic string and number methods
puts "The fox".length   # Returns the number of characters
puts "marco".index("m") # Returns the index of 'm'
puts 42.even?           # Check if 42 is even

# Example method calls
player.play(track1)
player.play(track2)

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
counter["ruby"] +=1
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
pallets = 0
weight = 0
while weight < 100  && pallets <= 5
 box = next_pallet()  # Assume method exists
 weight += box.weight
 pallets += 1
end

# Read from console and process
while (line = gets)
  puts line.downcase
end

# Conditional inline syntax
if radiation > 3000
  puts "High radiation warning!"
end
puts "Critical warning!" if radiation > 3000

# Loop examples
value = 4
while value < 1000
  value *= value
end

# One-line version
value = 4
value *= value while value < 1000

# Regex examples
/Go|Rust/
/\w+@\w+\.\w+/
/Ruby.*Python/
/Java(Script|Ruby)/


line = gets 
if line =~ /Ruby| Rust/
  puts "Language found: #{line}"
end

line = gets
if line.match?(/Ruby|Rust/)
  puts "Language mentioned: #{line}"
end

# Substitution examples
line = gets
new_line = line.sub(/Python/, "Ruby")
another_line = line.gsub(/JavaScript|Python/, "Ruby")

# Iterators and blocks
item.each { puts "Hello"}
item.each do 
  club.enroll(member)
  member.socialize
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
["cat", "dog" "horse"].each { |n| print n, " "}
5.times { print "*" }
3.upto(6) { |i| print i}
( "a".."e" ).each { |ch| print ch }
( "a".."e" ).each { print _1 }

# Command-line arguments
puts "You passed #{ARGV.size} arguments"
p ARGV