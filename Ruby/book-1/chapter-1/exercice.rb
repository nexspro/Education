# =========================================
# 1) Title & Overview
# =========================================
# Ruby basics: printing to the console, defining a small method,
# string interpolation, and trimming whitespace.
# Goal: keep it runnable and show how the same `+` operator
# behaves with both numbers and strings.

# =========================================
# 2) Printing to STDOUT
# =========================================
puts "Hello, coding world, from Nexs!" # prints a greeting message to the console
puts "Hello, It's me"                  # prints another message on a new line

# =========================================
# 3) Defining a method (polymorphic `+`)
# =========================================
# - Method `sum` takes two arguments.
# - In Ruby, the `+` operator is polymorphic:
#   * For numbers → performs arithmetic addition.
#   * For strings → performs concatenation.
# - Duck typing: any object that defines its own `#+` method can be used here.
# - Mixing incompatible types (e.g. "3" + 4) will raise a TypeError.
def sum(number1, number2)
  number1 + number2       # returns the result of calling `+` on the first argument
end

# =========================================
# 4) Calling the method with different types
# =========================================
puts sum(6, 8)         # call sum with two integers → 6 + 8 = 14
puts sum("Leo", "Cat") # call sum with two strings → concatenation = "LeoCat"

# =========================================
# 5) String interpolation with current time
# =========================================
# Notes:
# - `Time.now` returns the current date and time (system-dependent).
# - Inside "#{...}", the expression is evaluated and inserted into the string.
# - For custom formatting, use `strftime("%Y-%m-%d %H:%M:%S")`.
puts "The time is now #{Time.now}" # prints "The time is now ..." with current time

# =========================================
# 6) Trimming whitespace with String#strip
# =========================================
# Notes:
# - String#strip removes whitespace from both ends of the string.
# - Whitespace includes spaces, tabs (\t), and newline characters (\n, \r\n).
puts "hello".strip         # => "hello" (no extra spaces to remove)
puts "\tgoodbye\r\n".strip # => "goodbye" (tabs and line breaks removed)