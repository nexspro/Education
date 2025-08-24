require "csv"
# ProductItem: a simple value object for one inventory row
# code: unique identifier of the item
# unit_price: price as a Float
class ProductItem
  attr_reader :code
  attr_accessor :unit_price
  def initialize(code, unit_price)
    @code = String(code).strip
    @unit_price = Float(unit_price)
  end

  # Pretty print for quick inspection
  def to_s
    "Code: #{@code}, Unit price: #{@unit_price}"
  end

  # Price converted to cents for precise math
  def price_in_cents
    (@unit_price * 100).round
  end

  # Assign price from cents
  def price_in_cents=(cents)
    @unit_price = Float(cents) / 100.0
  end

  # Update price safely
  def update_price(new_price)
    @unit_price = Float(new_price)
  end
end

# StockImporter: loads inventory from CSV and exposes simple stats
# Expected CSV headers: "Code" and "UnitPrice"
class StockImporter
  def initialize
    @items = []
  end

  # Load rows from CSV into ProductItem objects.
  # Skips invalid rows and logs a warning to STDERR.
  def load_csv(file_name = "stock.csv")
    path = File.expand_path(file_name, __dir__)
    CSV.foreach(path, headers: true) do |row|
      code  = row["Code"]
      price = row["UnitPrice"]
      @items << ProductItem.new(code, price) if code && price
    end
  end

  # Total value across all items
  def total_value
    total_cents = @items.sum(&:price_in_cents)
    total_cents / 100.0
  end

  # Frequency map
  def count_by_code
    counts = Hash.new(0)
    @items.each { |it| counts[it.code] += 1 }
    counts
  end
   
  # Access all loaded items
  def all
    @items
  end
end

# Main program using ARGV
if __FILE__ == $0
  importer = StockImporter.new
  if ARGV.empty?
    importer.load_csv(File.join(__dir__, "stock.csv"))
  else
    ARGV.each do |csv_file|
      path = File.expand_path(csv_file, __dir__)
      importer.load_csv(path)
    end
  end
  puts "Items loaded: #{importer.all.size}"
  puts "Total value of stock: #{format('%.2f', importer.total_value)}"
  puts "Count by code: #{importer.count_by_code}"
end

# Demo usage 
p1 = ProductItem.new("code-1", 3)
p p1
puts p1

p2 = ProductItem.new("code-2", 3.14)
p p2
puts p2

p3 = ProductItem.new("code-3", "5.67")
p p3
puts p3

item = ProductItem.new("code-4", 12.34)
puts "Code = #{item.code}"
puts "Unit price = #{item.unit_price}"

# Apply discount (25% off)
item.update_price(item.unit_price * 0.75)
puts "New price after discount = #{item.unit_price}"

# Example with cents conversion
gadget = ProductItem.new("code-5", 33.80)
puts "Price = #{gadget.unit_price}"
puts "Price in cents = #{gadget.price_in_cents}"

gadget.price_in_cents = 1234
puts "Price = #{gadget.unit_price}"
puts "Price in cents = #{gadget.price_in_cents}"

# Example: visibility of methods in a class
class DemoClass
  # Public method
  def method_a
    "I am public"
  end

  protected
  # Protected method: accessible within the same class or subclasses
  def method_b
    "I am protected"
  end

  private
  # Private method: accessible only inside the class
  def method_c
    "I am private"
  end

  public
  def method_d
    "I am also public"
  end
end

# Alternative: declare methods first, then set visibility
class DemoAlt
  def method_a; "A"; end
  def method_b; "B"; end
  def method_c; "C"; end
  def method_d; "D"; end
  public :method_a, :method_d
  protected :method_b
  private :method_c
end

# Alternative: inline visibility in method signature  
class DemoInline
  def method_a; "A"; end
  protected def method_b; "B"; end
  private def method_c; "C"; end
  public def method_d; "D"; end
end

# Example: encapsulating state with protected accessors
class Wallet
  protected attr_accessor :balance
  def initialize(balance)
    @balance = Integer(balance)
  end

  # Public API to mutate the balance safely
  def deposit!(amount)
    @balance += Integer(amount)
  end

  def withdraw!(amount)
    @balance -= Integer(amount)
  end

  # Compare balances between two wallets
  def richer_than?(other)
    @balance > other.balance
  end

  def current_balance
    balance
  end
end

# Transaction that moves money between wallets
class Transfer
  def initialize(from_wallet, to_wallet)
    @from_wallet = from_wallet
    @to_wallet   = to_wallet
  end

  def execute(amount)
    @from_wallet.withdraw!(amount)
    @to_wallet.deposit!(amount)
  end

  private def debit(wallet, amount)
    wallet.balance -= amount
  end

  private def credit(wallet, amount)
    wallet.balance += amount
  end
end
wallet_a = Wallet.new(100)
wallet_b = Wallet.new(200)
transaction = Transfer.new(wallet_b, wallet_a)
transaction.execute(50)
puts "A: #{wallet_a.current_balance}"
puts "B: #{wallet_b.current_balance}"
puts "A richer than B? #{wallet_a.richer_than?(wallet_b)}"

# Example: variables and object references
name = "Alex"
puts "The object in 'name' is a #{name.class}"
puts "The object has an id of #{name.object_id}"
puts "and a value of '#{name}'"

# Both variables point to the same object
str1 = "Hello"
str2 = str1 # both reference the same object

# Mutating str1 also affects str2
str1[0] = "J"
puts "str1 is #{str1}"
puts "str2 is #{str2}" 

# Duplication creates a copy
str1 = "Hello"
str2 = str1.dup # str2 is a new object with the same value
str1[0] = "J"
puts "str1 is #{str1}"
puts "str2 is #{str2}"

# Freezing an object makes it immutable
str1 = "Hello"
str2 = str1
str1.freeze
puts str1

# Example: reopening a class and adding behavior
class Document
  attr_accessor :title
end 

class Document
  def uppercase_title
    title.upcase
  end
end
doc = Document.new
doc.title = "my book"
puts "Uppercased title: #{doc.uppercase_title}"

# Example: adding methods to core classes
class String
  # Removes leading/trailing spaces and collapses all whitespace into single spaces
  def squish
    self.strip.gsub(/\s+/, " ")
  end
end

class TextTools
  # Same as above, but as a class method in a utility class
  def self.squish(str)
    str.strip.gsub(/\s+/, " ")
  end
end
puts "This \n string \t has   whitespace".squish
puts TextTools.squish(" Another   line   here ")