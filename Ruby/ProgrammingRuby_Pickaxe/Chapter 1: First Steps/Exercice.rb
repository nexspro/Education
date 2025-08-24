# Print a simple greeting message to the console
puts "Hello, coding world, from Nexs!"

# Define a method that adds two arguments
# If the arguments are numbers, it will perform arithmetic addition
# If the arguments are strings, it will concatenate them
def sum(number1, number2)
  number1 + number2
end

# Call the sum method with integers
puts sum(6, 8)

# Call the sum method with strings
puts sum("Leo", "Cat")

# Print another greeting message
puts "Hello, Its Me"

# Print the current date and time using string interpolation
puts "The time is now #{Time.now}"

# Remove whitespace from both ends of the string "hello"
puts "hello".strip

# Remove leading tab and trailing carriage return/newline characters
puts "\tgoodbye\r\n".strip