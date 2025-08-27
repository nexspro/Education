require "csv"
# Load the standard Ruby CSV library for reading and parsing CSV files.

# =========================================
# 1) ProductItem: represents one row in the inventory
# =========================================
# - code: unique identifier of the product
# - unit_price: price stored as a Float
class ProductItem                                # define a class to model a single inventory item
  attr_reader :code                              # expose a read-only getter for @code
  attr_accessor :unit_price                      # expose a read/write getter+setter for @unit_price

  def initialize(code, unit_price)               # constructor called with a code and a unit_price
    @code = String(code).strip                   # coerce code to String and remove surrounding spaces
    @unit_price = Float(unit_price)              # coerce unit_price to Float for numeric operations
  end

  # Pretty print for quick inspection
  def to_s                                       # override default string representation
    "Code: #{@code}, Unit price: #{@unit_price}" # return a human-readable summary of the item
  end

  # Price converted to cents for precise math (avoids floating-point issues)
  def price_in_cents                             # compute the price in whole cents as an Integer
    (@unit_price * 100).round                    # multiply by 100 and round to nearest cent
  end

  # Assign price from cents
  def price_in_cents=(cents)                     # custom writer to set price using cents
    @unit_price = Float(cents) / 100.0           # convert cents back to a Float currency amount
  end

  # Update price safely
  def update_price(new_price)                    # public API to change the price
    @unit_price = Float(new_price)               # coerce input to Float to keep type consistent
  end
end

# =========================================
# 2) StockImporter: loads inventory from CSV and provides statistics
# =========================================
class StockImporter                                           # define a class responsible for loading/aggregating items
  def initialize                                              # constructor for the importer
    @items = []                                               # initialize an empty array to store ProductItem objects
  end

  # Load rows from CSV into ProductItem objects.
  def load_csv(file_name = "stock.csv")                       # method to read a CSV file; default name is "stock.csv"
    path = File.expand_path(file_name, __dir__)               # build an absolute path relative to the current file
    CSV.foreach(path, headers: true) do |row|                 # iterate over each CSV row as a hash of header=>value
      code  = row["Code"]                                     # read the "Code" column from the current row
      price = row["UnitPrice"]                                # read the "UnitPrice" column from the current row
      @items << ProductItem.new(code, price) if code && price # append a ProductItem unless data is missing
    end                                                       # end CSV.foreach loop
  end                                                         # end load_csv

  # Total value across all items (in main currency)
  def total_value                                             # compute the total inventory value as a Float
    total_cents = @items.sum(&:price_in_cents)                # sum the price_in_cents of every ProductItem
    total_cents / 100.0                                       # convert the aggregate cents back to currency units
  end

  # Frequency map: counts how many times each code appears
  def count_by_code                                           # build a histogram of items per product code
    counts = Hash.new(0)                                      # start with a hash defaulting missing keys to 0
    @items.each { |it| counts[it.code] += 1 }                 # increment count for each item's code
    counts                                                    # return the completed frequency hash
  end
   
  # Access all loaded items
  def all                                                     # simple accessor to expose the internal items array
    @items                                                    # return the array of ProductItem objects
  end
end

# =========================================
# 3) Main program using ARGV
# =========================================
if __FILE__ == $0                                                      # only run this block if file is executed directly (not required by another script)
  importer = StockImporter.new                                         # create a new importer instance
  if ARGV.empty?                                                       # check if no arguments were passed from the command line
    importer.load_csv(File.join(__dir__, "stock.csv"))                 # load default "stock.csv" file from the same directory
  else                                                                 # otherwise process all arguments passed as CSV file names
    ARGV.each do |csv_file|                                            # loop through each argument
      path = File.expand_path(csv_file, __dir__)                       # convert to absolute path relative to current directory
      importer.load_csv(path)                                          # load each specified CSV file
    end
  end
  puts "Items loaded: #{importer.all.size}"                            # print number of items loaded
  puts "Total value of stock: #{format('%.2f', importer.total_value)}" # print formatted total value (2 decimal places)
  puts "Count by code: #{importer.count_by_code}"                      # print frequency of each code as a hash
end

# =========================================
# 4) Demo usage of ProductItem
# =========================================
p1 = ProductItem.new("code-1", 3)                    # create ProductItem with integer price
p p1                                                 # inspect the object (shows internal structure)
puts p1                                              # calls custom to_s, prints human-readable string

p2 = ProductItem.new("code-2", 3.14)                 # create ProductItem with float price
p p2                                                 # inspect internal structure
puts p2                                              # print custom to_s string

p3 = ProductItem.new("code-3", "5.67")               # create ProductItem with string price
p p3                                                 # inspect object
puts p3                                              # print with to_s

item = ProductItem.new("code-4", 12.34)              # create another ProductItem
puts "Code = #{item.code}"                           # access and print code using reader
puts "Unit price = #{item.unit_price}"               # access and print unit_price

# Apply discount (25% off)
item.update_price(item.unit_price * 0.75)            # reduce price by 25% using update_price method
puts "New price after discount = #{item.unit_price}" # print discounted price

# Example with cents conversion
gadget = ProductItem.new("code-5", 33.80)            # create ProductItem with float
puts "Price = #{gadget.unit_price}"                  # print price in float
puts "Price in cents = #{gadget.price_in_cents}"     # convert to cents and print

gadget.price_in_cents = 1234                         # assign new price using cents
puts "Price = #{gadget.unit_price}"                  # print updated price in float
puts "Price in cents = #{gadget.price_in_cents}"     # print updated price in cents

# =========================================
# 5) Method visibility example
# =========================================
class DemoClass
  # Public method (default visibility)
  def method_a
    "I am public"              # accessible anywhere
  end

  protected
  def method_b                 # protected: accessible by this class and subclasses
    "I am protected"
  end

  private
  def method_c                 # private: only accessible inside this class
    "I am private"
  end

  public
  def method_d                 # explicitly made public again
    "I am also public"
  end
end

# Alternative: declare methods first, then set visibility
class DemoAlt
  def method_a; "A"; end      # define method_a
  def method_b; "B"; end      # define method_b
  def method_c; "C"; end      # define method_c
  def method_d; "D"; end      # define method_d
  public :method_a, :method_d # mark method_a and method_d as public
  protected :method_b         # mark method_b as protected
  private :method_c           # mark method_c as private
end 

# Alternative: inline visibility in method signature
class DemoInline
  def method_a; "A"; end           # public by default
  protected def method_b; "B"; end # method_b defined as protected inline
  private def method_c; "C"; end   # method_c defined as private inline
  public def method_d; "D"; end    # method_d defined as public inline
end

# =========================================
# 6) Wallet & Transfer example (encapsulation + interaction)
# =========================================
class Wallet
  protected attr_accessor :balance                         # declare a protected getter/setter for @balance (not accessible publicly)

  def initialize(balance)                                  # constructor receives an initial balance
    @balance = Integer(balance)                            # coerce to Integer to enforce a strict numeric type
  end

  def deposit!(amount)                                     # public method: add money to the wallet
    @balance += Integer(amount)                            # coerce and increment balance
  end

  def withdraw!(amount)                                    # public method: remove money from the wallet
    @balance -= Integer(amount)                            # coerce and decrement balance
  end

  def richer_than?(other)                                  # public comparator using another wallet
    @balance > other.balance                               # allowed because `balance` is protected (accessible between instances of same class)
  end

  def current_balance                                      # public, read-only-style accessor that exposes the value safely
    balance                                                # call the protected reader internally and return it
  end
end
class Transfer
  def initialize(from_wallet, to_wallet)                   # constructor with source and destination wallets
    @from_wallet = from_wallet                             # store source wallet
    @to_wallet   = to_wallet                               # store destination wallet
  end

  def execute(amount)                                      # public API to perform a transfer
    @from_wallet.withdraw!(amount)                         # withdraw from the source
    @to_wallet.deposit!(amount)                            # deposit into the destination
  end

  private def debit(wallet, amount)                        # private helper: directly decrease balance (not used here)
    wallet.balance -= amount                               # uses the wallet's protected accessor; allowed within this class
  end

  private def credit(wallet, amount)                       # private helper: directly increase balance (not used here)
    wallet.balance += amount                               # symmetrical to debit
  end
end
wallet_a = Wallet.new(100)                                 # create a wallet with balance 100
wallet_b = Wallet.new(200)                                 # create a wallet with balance 200
transaction = Transfer.new(wallet_b, wallet_a)             # set up transfer from B to A
transaction.execute(50)                                    # move 50 units from wallet_b to wallet_a
puts "A: #{wallet_a.current_balance}"                      # => 150 (100 + 50)
puts "B: #{wallet_b.current_balance}"                      # => 150 (200 - 50)
puts "A richer than B? #{wallet_a.richer_than?(wallet_b)}" # compare balances and print result

# =========================================
# 7) Variables and object references
# =========================================
name = "Alex"                                    # assign a String object to variable `name`
puts "The object in 'name' is a #{name.class}"   # print the class of the object (String)
puts "The object has an id of #{name.object_id}" # print the internal Ruby object id
puts "and a value of '#{name}'"                  # print the stored string value

# Both variables point to the same object
str1 = "Hello"                                   # create a new String object
str2 = str1                                      # copy the reference (both point to the same object)
str1[0] = "J"                                    # mutate the first character of the shared object
puts "str1 is #{str1}"                           # => "Jello" (mutation visible here)
puts "str2 is #{str2}"                           # same mutation visible because str2 references the same object

# Duplication creates a copy
str1 = "Hello"                                   # create a fresh String object
str2 = str1.dup                                  # duplicate it: str2 now references a separate copy
str1[0] = "J"                                    # mutate str1 only
puts "str1 is #{str1}"                           # => "Jello" (changed)
puts "str2 is #{str2}"                           # => "Hello" (unchanged, because it's a different object)

# Freezing an object makes it immutable
str1 = "Hello"                                   # assign a new String to str1
str2 = str1                                      # str2 references the same object
str1.freeze                                      # prevent any future mutations on this String
puts str1                                        # print the frozen string (still readable)

# =========================================
# 8) Reopening a class and adding behavior
# =========================================
class Document
  attr_accessor :title                          # define an attribute with getter and setter for @title
end 

class Document                                  # reopen the same class (allowed in Ruby)
  def uppercase_title                           # add a new method
    title.upcase                                # return the title converted to uppercase
  end
end
doc = Document.new                              # create a new Document instance
doc.title = "my book"                           # set its title using the writer method
puts "Uppercased title: #{doc.uppercase_title}" # => "MY BOOK"

# =========================================
# 9) Extending core classes + utility class
# =========================================
class String
  # Custom instance method for String objects
  # Removes leading/trailing whitespace (strip)
  # and collapses multiple whitespace chars into a single space
  def squish
    self.strip.gsub(/\s+/, " ")                  # strip → remove edges; gsub(/\s+/, " ") → normalize whitespace
  end
end

class TextTools
  # Define a class method (self.squish) that performs the same operation
  # This works on any string passed as an argument (utility style)
  def self.squish(str)
    str.strip.gsub(/\s+/, " ")
  end
end
puts "This \n string \t has   whitespace".squish # call squish directly on a String instanc
puts TextTools.squish(" Another   line   here ") # call squish as a class utility method