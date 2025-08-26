# =========================================
# 1) Title & Overview
# =========================================
# Ruby basics: printing, a tiny method, string interpolation, and whitespace trimming.
# Goal: keep it runnable and show how the same `+` operator behaves with different types.

# =========================================
# 2) Printing to STDOUT
# =========================================
puts "Hello, coding world, from Nexs!"
puts "Hello, It's me"

# =========================================
# 3) Defining a method (polymorphic `+`)
# =========================================
# Intent:
# - Show that Ruby dispatches `+` to the receiver’s `#+` method.
#   * Numbers → arithmetic addition
#   * Strings → concatenation
# Notes:
# - Duck typing: any object that implements `#+` can work here.
# - Mixing incompatible types (e.g., "3" + 4) raises TypeError; convert explicitly if needed.
def sum(number1, number2)
  number1 + number2
end

# =========================================
# 4) Calling the method with different types
# =========================================
puts sum(6, 8)           # => 14 (Integer + Integer)
puts sum("Leo", "Cat")   # => "LeoCat" (String + String)

# =========================================
# 5) String interpolation with current time
# =========================================
# NOTE:
# - Time.now uses the system’s local timezone.
# - Use `Time.now.strftime("%Y-%m-%d %H:%M:%S")` to format if needed.
puts "The time is now #{Time.now}"

# =========================================
# 6) Trimming whitespace with String#strip
# =========================================
# strip removes leading and trailing whitespace (spaces, tabs, newlines, CR/LF).
puts "hello".strip           # => "hello" (no change)
puts "\tgoodbye\r\n".strip   # => "goodbye"