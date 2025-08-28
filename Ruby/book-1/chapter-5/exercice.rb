# =========================================
# 1) Redefining a method in a class
# =========================================
class DarkKnight               # define a demo class         
  def who_is_sidekick          # first definition of the method     
    puts "Casey Rowan"         # prints a placeholder name
  end

  def who_is_sidekick          # redefine the same method (overrides the first)
    puts "Mira Vale"           # prints a different name — this version is effective
  end
end

DarkKnight.new.who_is_sidekick # instantiate and call → uses the second definition

# =========================================
# 2) Method redefinitions & one-line defs; explicit nil return
# =========================================
def echo_value(arg)            # standard multi-line method with one parameter
  puts arg                     # side effect: print the argument; return value is nil
end
echo_value("ahoy")             # call the method → outputs "ahoy"

def echo_value(arg) = puts arg # Ruby 3 one-line method redefinition (same behavior)
echo_value("ahoy again")       # call the new definition → outputs "ahoy again"

def echo_value; end            # redefine with no body → returns nil explicitly
p echo_value                   # `p` shows the return value (nil)


# =========================================
# 3) Predicate & type-introspection examples
# =========================================
p 7.even?                 # => false (7 is odd)
p 14.even?                # => true  (14 is even)
p 7.instance_of?(Integer) # => true  (7 is an Integer instance)

# =========================================
# 4) String#chop (non-destructive) vs String#chop! (destructive)
# =========================================
snippet = "Crafting clean code" # define a sample string
p snippet.chop                  # print a COPY without the last character (non-destructive)
p snippet                       # original string is unchanged

p snippet.chop!                 # remove the last character IN PLACE (destructive); returns the new value or nil
p snippet                       # original string is now mutated

# =========================================
# 5) Value object with operator overloading (+) and one-line to_s
# =========================================
class Vector2                             # simple 2-D value object (renamed to avoid overlap)
  attr_reader :x, :y                      # read-only accessors for the two components

  def initialize(x, y)                    # constructor takes two components
    @x = x                                # assign @x
    @y = y                                # assign @y
  end

  def to_s = "(#{x}, #{y})"               # concise string representation using one-line def

  def +(other)                            # overload the + operator to add two Vector2 objects
    Vector2.new(x + other.x, y + other.y) # return a NEW instance (inputs remain unchanged)
  end
end

p1 = Vector2.new(2, 5)                    # first vector (2,5)
p2 = Vector2.new(7, 1)                    # second vector (7,1)
puts p1 + p2                              # vector addition → prints "(9, 6)"

# =========================================
# 6) Class method vs singleton methods on instances
# =========================================
class Workstation                       # demo class (renamed)
  def self.banner                       # class method (invoked on Workstation itself)
    "System policy denies that request" # return a string; no side effects
  end
end

linux = Workstation.new                 # create first instance
win   = Workstation.new                 # create second instance

def linux.identity = "I'm Linux"        # define a SINGLETON method only on `linux`
def win.identity   = "I'm Windows"      # define a SINGLETON method only on `win`

puts linux.identity                     # call per-instance method → "I'm Linux"
puts win.identity                       # call per-instance method → "I'm Windows"
puts Workstation.banner                 # call class method → "System policy denies that request"

# =========================================
# 7) Positional params, return values, defaults, and computed defaults
# =========================================
def report_three(arg1, arg2, arg3)                      # define a method with exactly three positional arguments
  puts "Received arguments: #{arg1}, #{arg2}, #{arg3}"  # side effect: print all three in order
end
report_three("Ruby", 42, true)                          # call with mixed types (String, Integer, Boolean)

def greet_from_helper                                   # method without parameters
  "Hello from greet_from_helper"                        # returns a String (no printing here)
end
puts greet_from_helper                                  # print the returned String

def jazz_trio(a1 = "Nina", a2 = "Evans", a3 = "Blakey") # defaults used when arguments are omitted
  "#{a1}, #{a2}, #{a3}"                                 # return a single formatted String
end

p jazz_trio                                             # uses all defaults
p jazz_trio("Bart")                                     # overrides the first default only
p jazz_trio("Bart", "Elwood")                           # overrides the first two defaults
p jazz_trio("Bart", "Elwood", "Linus")                  # overrides all three defaults

def surround(word, pad_width = word.length / 2)         # second parameter default computed from the first
  "[" * pad_width + word + "]" * pad_width              # build brackets on both sides by repeating "[", "]"
end

p surround("elephant")                                  # uses computed default width
p surround("fox")                                       # uses computed default width for a short word
p surround("fox", 10)                                   # explicit padding width overrides the default

# =========================================
# 8) Splat capture for extra args; formatting inspection
# =========================================
def capture_tail(first_item, *others)               # *others collects any additional positional arguments into an Array
  "first=#{first_item} -- others=#{others.inspect}" # return a debug string showing the head and the collected tail
end

p capture_tail("alpha")                             # only head present; others = []
p capture_tail("alpha", "beta")                     # head = "alpha"; others = ["beta"]
p capture_tail("alpha", "beta", "gamma")            # head = "alpha"; others = ["beta","gamma"]

# =========================================
# 9) Inheritance, super, splat forwarding/ignoring
# =========================================
class BaseUnit
  def perform(task_a, task_b)                       # parent method expects exactly two positional args
    puts "BaseUnit handled #{task_a} and #{task_b}" # print both arguments
  end
end

class SubUnit < BaseUnit
  def perform(*_ignored)                            # accept any count of args; local name unused
    puts "SubUnit: before"                          # message before delegating
    super                                           # forward the SAME args up to BaseUnit#perform
    puts "SubUnit: after"                           # message after delegating
  end
end

class SubUnitSilent < BaseUnit
  def perform(*)                                    # anonymous splat → accept anything, ignore local variable names
    puts "SubUnitSilent: before"                    # message before delegating
    super                                           # still forwards whatever was passed
    puts "SubUnitSilent: after"                     # message after delegating
  end
end

u1 = SubUnit.new.perform("kiwi", "mango")           # demonstrates before → parent → after sequence
u2 = SubUnitSilent.new.perform("plum", "peach")     # same, with different labels and values

# =========================================
# 10) Splat forwarding between methods; first/rest/last capture
# =========================================
class DemoForwarder
  def route_all(*)                                                                           # capture-all placeholder for any incoming args
    display_joined(*)                                                                        # forward ALL captured args unchanged
  end

  def display_joined(*packed_args)                                                           # receive the forwarded args as an Array
    puts packed_args.join(", ")                                                              # join with commas for display
  end
end

puts DemoForwarder.new.route_all("x", "y", "z")                                              # prints "x, y, z"

def unpack_edges(first_elem, *middle, last_elem)                                             # capture the first and last, with a splat for the middle segment
  puts "First: #{first_elem.inspect}, middle: #{middle.inspect}, last: #{last_elem.inspect}" # show the decomposition
end

unpack_edges(7, 8)                                                                           # first=7,  middle=[],     last=8
unpack_edges(7, 8, 9)                                                                        # first=7,  middle=[8],    last=9
unpack_edges(7, 8, 9, 10)                                                                    # first=7,  middle=[8,9],  last=10

# =========================================
# 11) Keyword arguments (required & defaults), **rest and ** forwarding
# =========================================
def format_location(city:, state:, zip:)                     # define a method with REQUIRED keyword args
  "#{city}, #{state} #{zip}"                                 # return a formatted address string
end
p format_location(city: "Aurora", state: "CO", zip: "80014") # call with all keywords supplied

def format_location(city:, state: "NM", zip:)                # redefine with a DEFAULT for `state`
  "#{city}, #{state} #{zip}"                                 # same formatting; later definition overrides earlier
end
p format_location(city: "Taos", zip: "87571")                # uses default state "NM"

def mix_pos_and_kwargs(head, **kw_tail)                      # positional first arg + ** captures remaining keywords in a Hash
  "head=#{head}. kw_tail=#{kw_tail.inspect}"                 # return a debug string showing both parts
end
p mix_pos_and_kwargs("alpha")                                # kw_tail = {}
p mix_pos_and_kwargs("alpha", color: "crimson")              # kw_tail = {color:"crimson"}
p mix_pos_and_kwargs("alpha", color: "crimson", size: "xl")  # kw_tail = {color:"crimson", size:"xl"}

class Coordinator
  def handle_location(city:, zip:)                           # expects two REQUIRED keyword args
    puts "Coordinator received city=#{city}, zip=#{zip}"     # print a normalized message
  end
end
class Delegate < Coordinator
  def relay(**kw)                                            # accept arbitrary keywords in **kw
    puts handle_location(**kw)                               # forward them as-is using double-splat
  end
end

agent = Delegate.new                                         # create an instance of Delegate
agent.relay(city: "Riverton", zip: "84065")                  # call with keywords; forwards to Coordinator#handle_location

# =========================================
# 12) Option hash APIs (classic Ruby pattern)
# =========================================
class TrackCollection
  def search(field, options = {})                                      # idiomatic "options hash" parameter
    puts "Searching by #{field.inspect}; options: #{options.inspect}"  # show both for clarity
  end
end

TrackCollection.new.search(:titles, genre: "fusion", duration_lt: 240) # pass a mix of options

class TrackCollection
  def search(field, options = {})                                      # reopen the class to change output formatting
    puts "Field: #{field.inspect}"                                     # print the field on its own line
    options.each do |key, value|                                       # iterate over each key/value pair
      puts "  #{key} => #{value}"                                      # print each option line by line
    end
  end
end

TrackCollection.new.search(:titles, genre: "fusion", duration_lt: 240) # call the redefined version


# =========================================
# 13) Blocks & yield: passing behavior
# =========================================
def apply_twice(input)                                                    # method that expects a block to be given
  yield(input * 2)                                                        # call the block with a transformed value
end

p apply_twice(3) { |v| "received #{v}" }                                  # => "received 6" (block return is printed by p)
p apply_twice("tom") { |v| "and then #{v}" }                              # => "and then tomtom"

class LevyCalculator
  def initialize(label, &strategy)                                        # capture a block into `strategy` for later use
    @label, @strategy = label, strategy                                   # store label and callable
  end

  def compute(amount)                                                     # apply the stored block to a given amount
    "#{@label} on #{amount} = #{@strategy.call(amount)}"                  # interpolate the result of calling the strategy
  end
end

levy = LevyCalculator.new("local levy") { |amt| (amt * 0.0825).round(2) } # 8.25% rate with rounding
p levy.compute(120)                                                       # => "local levy on 120 = 9.9"
p levy.compute(275)                                                       # => "local levy on 275 = 22.69"

class BaseProcess
  def run                                                                 # base method optionally accepts a block
    puts "BaseProcess running"                                            # pre-message
    yield if block_given?                                                 # execute the provided block if any
  end
end
class SubProcess < BaseProcess
  def run(&)                                                              # capture the incoming block (anonymous block arg)
    puts "SubProcess before"                                              # message before delegating
    super                                                                 # delegate to BaseProcess#run, forwarding the block
    puts "SubProcess after"                                               # message after delegating
  end
end

SubProcess.new.run { puts "executing the block now!" }                    # demonstrate passing behavior through `super`

# =========================================
# 14) Argument forwarding (…) and full signature helper
# =========================================
class RelayBox                                                        # renamed demo class to avoid overlap
  def dispatch(...)                                                   # forward ALL incoming args/kwargs/block with the triple-dot
    handle_all(...)                                                   # pass them through unchanged to the helper
  end

  def handle_all(*args, **kwargs, &blk)                               # explicitly capture positional, keyword, and block
    puts "Received arguments:"                                        # label for readability
    p args                                                            # show positional arguments as an Array
    p kwargs                                                          # show keyword arguments as a Hash
    blk&.call                                                         # safely call the block if provided
  end
end

RelayBox.new.dispatch(1, 2, x: 10, y: 20) { puts "Hello from block" } # demo call with mixed args + block

# =========================================
# 15) Nested def (defines a top-level method) + callback progress
# =========================================
def gateway                                                            # define an outer method
  def stream_mp3(track, speed:, &on_update)                            # define an inner (top-level) method; accepts a block callback
    puts "Starting stream of #{track} at speed = #{speed}"             # status message
    5.times do |i|                                                     # loop 5 times to simulate progress
      sleep 0.2                                                        # artificial delay to mimic work
      progress = (i + 1) * 20                                          # compute percentage (20, 40, ..., 100)
      on_update.call(progress) if on_update                            # invoke the callback if given
    end
    puts "Stream of #{track} complete!"                                # completion message
  end
end

def on_progress(p)                                                     # standalone progress reporter
  puts "Progress: #{p}"                                                # print the numeric progress value
end
gateway.stream_mp3("neon-dream", speed: "slow") { |p| on_progress(p) } # call inner method via the outer name (as in original)


# =========================================
# 16) Standard library calls: File and Math
# =========================================
testfile = File.join(__dir__, "testfile.txt") # build a path relative to this file’s directory
p "Taille : #{File.size(testfile)} Octets"    # show file size in bytes
p Math.sin(Math::PI/4)                        # evaluate sin(π/4) = √2/2

# =========================================
# 17) Template Method-style writer (public helpers), then private helpers
# =========================================
class ReceiptWriter                                 # renamed class (same behavior)
  def initialize(invoice)                           # accept a Hash-like invoice
    @invoice = invoice                              # store for later use
  end

  def write_on(io)                                  # orchestrator method
    write_header_on(io)                             # header section
    write_body_on(io)                               # items section
    write_totals_on(io)                             # totals section
  end

  def write_header_on(io)                           # PUBLIC helper: header
    io.puts "=== RECEIPT ==="                       # print title
    io.puts "Customer: #{@invoice[:customer]}"      # print customer name
  end

  def write_body_on(io)                             # PUBLIC helper: body
    io.puts "Items:"                                # label for the list
    @invoice[:items].each do |item|                 # iterate items collection
      io.puts "- #{item}"                           # print each item line
    end
  end

  def write_totals_on(io)                           # PUBLIC helper: totals
    io.puts "Total: #{@invoice[:total]}"            # print the total amount
  end
end

ticket = {                                          # example invoice data (renamed variables/values)
  customer: "Jordan",
  items:    ["Notebook", "USB-C Cable", "Sticker"],
  total:    "64.90€"
}
ReceiptWriter.new(ticket).write_on($stdout)         # write the receipt to STDOUT

class ReceiptWriter                                 # reopen the class to demonstrate private helpers
  def initialize(invoice)                           # same initializer
    @invoice = invoice
  end
  
  def write_on(io)                                  # same orchestrator
    write_header_on(io)
    write_body_on(io)
    write_totals_on(io)
  end

  private def write_header_on(io)                   # PRIVATE helper: header
    io.puts "=== RECEIPT ==="
    io.puts "Customer: #{@invoice[:customer]}"
  end

  private def write_body_on(io)                     # PRIVATE helper: body
    io.puts "Items:"
    @invoice[:items].each do |item|
      io.puts "- #{item}"                           # note: indentation kept simple and readable
    end
  end

  private def write_totals_on(io)                   # PRIVATE helper: totals
    io.puts "Total: #{@invoice[:total]}"
  end
end

ticket = {                                          # second example with same shape
  customer: "Jordan",
  items:    ["Notebook", "USB-C Cable", "Sticker"],
  total:    "64.90€"
}
ReceiptWriter.new(ticket).write_on($stdout)         # write again using the private-helper version


# =========================================
# 18) Manual accessors; using self= writer; keywords again
# =========================================
class Individual
  def name=(new_name)                                                 # manual writer method
    @name = new_name                                                  # assign instance variable
  end

  def name                                                            # manual reader method
    @name                                                             # return instance variable
  end
end

person = Individual.new
person.name = "Ava Lin"                                               # call writer with '=' syntax
puts person.name                                                      # => "Ava Lin"
person.name = "Eli Stone"                                             # reassign
puts person.name                                                      # => "Eli Stone"

class Individual
  def name=(new_name)
    @name = new_name
  end

  def change_identity(new_name, address)                              # new method mutates state with both params
    self.name = "#{new_name} #{address}"                              # use self.name= so Ruby calls the writer
    @name
  end
end

person = Individual.new.change_identity("Liam Gray", "42 Galaxy Ave")
puts person                                                           # => "Liam Gray 42 Galaxy Ave"

def describe_place(city:, state:, zip:)                               # keywords: required args
  "Located in #{city}, #{state} #{zip}"                               # build formatted string
end

puts describe_place(city: "Denver", state: "CO", zip: "80202")
puts describe_place(zip: "94110", city: "San Francisco", state: "CA")

# =========================================
# 19) Return values, case with boolean conditions, multiple return & destructuring
# =========================================
def first_method
  "alpha"                       # return a simple string
end
p first_method                  # => "alpha"

def classify_number(num)        # case with boolean conditions
  case
  when num > 0 then "positive"
  when num < 0 then "negative"
  else "zero"
  end
end

p classify_number(15)           # => "positive"
p classify_number(0)            # => "zero"

def find_square_threshold
  100.times do |n|              # loop from 0 to 99
    sq = n * n
    return n, sq if sq > 1000   # return multiple values when threshold crossed
  end
end

p find_square_threshold         # => [32, 1024]
num, sq = find_square_threshold # destructuring assignment
p num                           # => 32
p sq                            # => 1024

# =========================================
# 20) Splat expansion (arrays & ranges) and double-splat for keywords
# =========================================
def five_values(a, b, c, d, e)                        # expects exactly 5 arguments
  "Got #{a}, #{b}, #{c}, #{d}, #{e}"
end

p five_values(1, 2, 3, 4, 5)
p five_values(1, 2, 3, *['x', 'y'])                   # expand array into arguments
p five_values(*['x', 'y'], 1, 2, 3)                   # splat at start
p five_values(*(20..24))                              # expand range 20..24 into args
p five_values(*[1, 2], 3, *(4..5))                    # mix splat array and splat range

def format_address(city:, state:, zip:)               # method with keyword args
  "Address: #{city}, #{state} #{zip}"
end

info = { city: "Seattle", state: "WA", zip: "98101" }
puts format_address(**info)                           # double-splat expands hash into keywords

# =========================================
# 21) Blocks vs Symbol#to_proc (concise map)
# =========================================
p ["a", "b", "c"].map { |s| s.upcase } # explicit block syntax
p ["a", "b", "c"].map(&:upcase)        # concise Symbol#to_proc shortcut

# =========================================
# 22) Functional style: 3 ways to pick an operator and apply over a range
# =========================================
# Goal: demonstrate three different approaches to dynamically choose
# between multiplication (*) and addition (+) and apply across 1..10.

print "(t)imes or (p)lus"                                      # prompt (simulated input here, not interactive)
op_choice = "t"                                                # simulated choice → "t" for times
print "number:"                                                # second prompt
factor = 7                                                     # simulated user input (number to apply)

# --- Approach 1: inline conditional with collect ---
if op_choice.start_with?("t")                                  # check operator selection
  puts((1..10).collect { |n| n * factor }.join(","))           # multiply
else
  puts((1..10).collect { |n| n + factor }.join(", "))          # add
end

# --- Approach 2: assign a lambda, then map with it ---
print "(t)imes or (p)lus"
op_choice = "t"                                                # reassign choice
print "number:"
factor = 4                                                     # new number for demo

operation = if op_choice.start_with?("t")                      # choose correct lambda
  ->(n) { n * factor }
else 
  ->(n) { n + factor }
end

puts((1..10).map(&operation).join(", "))                       # map with chosen lambda

# --- Approach 3: use Method#method to bind an operator directly ---
print "(t)imes or (p)lus"
op_choice = "t"
print "number:"
factor = 3

bound_op = factor.method(op_choice.start_with?("t") ? :* : :+) # choose :* or :+
puts((1..10).map(&bound_op).join(", "))                        # map using bound Method object