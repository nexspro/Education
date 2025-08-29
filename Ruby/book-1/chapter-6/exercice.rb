# =========================================
# 1) Inheritance basics + superclass chain
# =========================================
class Ancestor                # base class
  def say_hello               # instance method defined on the base
    puts "Hello from #{self}" # prints receiver via implicit #to_s
  end
end

class Descendant < Ancestor   # subclass inherits methods from Ancestor
end
Ancestor.new.say_hello        # calls method defined in the base class
Descendant.new.say_hello      # inherits and executes the same method

p Ancestor.superclass         # => Object (unless altered)
p Descendant.superclass       # => Ancestor
p Object.superclass           # => BasicObject
p BasicObject.superclass      # => nil (root of the hierarchy)


# =========================================
# 2) Reopen/define a class with initialize + to_s
# =========================================
class Profile                # small value type with a printable name
  def initialize(name)       # constructor receives one argument
    @name = name             # store in an instance variable
  end

  def to_s                   # string representation used by puts
    "Profile named #{@name}" # format a readable string
  end
end

puts Profile.new("Marin")    # => "Profile named Marin"

# =========================================
# 3) Polymorphic statuses via a factory + interface
# =========================================
def mood_string(task)                      # free function using duck-typed `task.status`
  case task.status                         # branch based on status string
  when "finished"   then "All set"
  when "running"    then "Still working"
  when "planned"    then "Not started yet"
  end
end

class Stage                                # base “enum-like” class with a factory
  def self.from(status_string)             # class factory returning a concrete Stage
    case status_string
    when "finished" then DoneStage.new
    when "running"  then ActiveStage.new
    when "planned"  then PlannedStage.new
    end
  end

  def done? = false                        # default implementation
  def mood = raise NotImplementedError     # abstract method to be overridden
end

class DoneStage < Stage
  def to_s = "finished"                    # printable label
  def done? = true                         # override
  def mood  = "All set"                    # specialized message
end


class ActiveStage < Stage
  def to_s = "running"                     # printable label
  def mood  = "Still working"              # specialized message
end

class PlannedStage < Stage
  def to_s = "planned"                     # printable label
  def mood  = "Not started yet"            # specialized message
end

puts Stage.from("finished").mood           # => "All set"
puts Stage.from("running").mood            # => "Still working"
puts Stage.from("planned").mood            # => "Not started yet"

# =========================================
# 4) Namespaces via modules + constants and methods
# =========================================
module Trigon                                 # math-ish namespace
  TAU = 6.283185308                           # constant (2π), different value than PI
  def self.sin(x) = Math.sin(x)               # module (singleton) methods
  def self.cos(x) = Math.cos(x)
end

module Ethics                                 # same names as math but different semantics
  SEVERE = 0                                  # symbolic constants
  MILD   = 1
  def self.judge(level)                       # unrelated “sin” concept → renamed to judge
    case level
    when SEVERE then "That’s a serious wrong"
    when MILD   then "That’s questionable"
    else              "Hard to classify"
    end
  end
end

p trig_val   = Trigon.sin(Trigon::TAU / 8)    # compute sin(τ/8)
p verdict    = Ethics.judge(Ethics::SEVERE)   # message for a severity level

# =========================================
# 5) Mixins: adding behavior with modules
# =========================================
module Tracer                                                         # reusable debug mixin
  def who_am_i?                                                       # instance helper uses class + id + name
    "#{self.class.name} (id: #{self.object_id}) — name: #{self.name}"
  end

  def to_s                                                            # override to_s to delegate to who_am_i?
    who_am_i?
  end
end

class Turntable                                                       # first concrete class using the mixin
  include Tracer                                                      # brings in #who_am_i? and #to_s
  attr_reader :name                                                   # expose @name for who_am_i?
  def initialize(name) ; @name = name ; end                           # store provided name
end

class CassetteDeck                                                    # second class with the same mixin
  include Tracer
  attr_reader :name
  def initialize(name) ; @name = name ; end
end

puts Turntable.new("Kind of Blue")                                    # prints tracer-formatted identity
puts CassetteDeck.new("Hunky Dory")                                   # prints tracer-formatted identity

# =========================================
# 6) Comparable mixin with <=> and sorting
# =========================================
class Coder                                    # comparable by name (lexical)
  include Comparable                           # expects we define #<=>
  attr_reader :name                            # expose the comparison key
  def initialize(name) ; @name = name ; end    # store name
  def to_s = @name.to_s                        # readable string
  def <=>(other) = name <=> other.name         # three-way comparison
end

c1 = Coder.new("Ada")
c2 = Coder.new("Grace")
c3 = Coder.new("Linus")

if c1 > c2                                     # uses Comparable operators built from <=>
  puts "#{c1.name}'s name > #{c2.name}'s name"
end

puts "Sorted list:"                            # header
puts [c1, c2, c3].sort                         # relies on <=> to order Coders

# =========================================
# 7) Class extension: build instances from delimited strings
# =========================================
module FactoryFromString
  def build_from(str, delimiter = ",")             # split string and splat args to constructor
    new(*str.split(delimiter))                     # call the real .new with the parts
  end
end

class Character                                     # new class instead of Person
  extend FactoryFromString                          # adds .build_from class method
  def initialize(first_name, last_name)             # expects two components
    @first_name, @last_name = first_name, last_name
  end
  def label = "#{@first_name} #{@last_name}"        # formatted full name
end

mage  = Character.build_from("Aria, Dawn")          # use comma delimiter
knight = Character.build_from("Luthor|Shade", "|")  # use custom delimiter

puts mage.label, knight.label

# =========================================
# 8) Reduce & custom Enumerable class
# =========================================
p [2, 4, 6, 8, 10].reduce(:+)               # sum over integers
p ("n".."s").reduce(:+)                     # concatenation of letters

class VowelCollector
  include Enumerable
  def initialize(text) ; @text = text ; end # store provided text
  def each                                  # implement #each to yield vowels
    @text.scan(/[aeiou]/) { |v| yield v }         
  end
end

# =========================================
# 9) Summable mixin shared by multiple classes
# =========================================
module Summable
  def sum                                       # generic sum using reduce(:+)
    reduce(:+)
  end
end

class Array ; include Summable ; end            # monkey-patch Array
class Range ; include Summable ; end            # monkey-patch Range
class VowelCollector ; include Summable ; end   # add #sum to our custom class

vc = VowelCollector.new("dragons breathe fire")
puts vc.reduce(:+)                              # concatenate vowels
puts [3, 6, 9].sum                              # => 18
puts ("a".."f").sum                             # => "abcdef"
vc = VowelCollector.new("whispering winds")
puts vc.sum                                     # sum via mixin

# =========================================
# Observer pattern demo — renamed identifiers + line-by-line comments
# =========================================

module SignalBus                         # module acts as the observable mixin
  def listeners                          # accessor for the internal subscribers array
    @listeners ||= []                    # memoize the array the first time it’s used
  end

  def add_listener(obj)                  # register a subscriber object
    listeners << obj                     # append to the list
  end

  def notify_listeners                   # broadcast an update to all subscribers
    listeners.each { |l| l.update }      # call #update on each subscriber
  end
end

class AstroScheduler                     # concrete subject that can be observed
  include SignalBus                      # bring in listeners/add_listener/notify_listeners

  def initialize                         # constructor
    @listeners = []                      # initialize storage (explicit for clarity)
  end

  def add_watcher(watcher)               # alternate API name for adding a subscriber
    @listeners << watcher                # append using the ivar directly
  end
end

class Subscriber                         # simple observer
  def initialize(name)                   # constructor takes a label/name
    @name = name                         # store name in an instance variable
  end

  def update                             # callback invoked by the subject
    puts "Subscriber #{@name} notified!" # side effect: print a message
  end
end

sch = AstroScheduler.new                 # create the observable subject
sch.add_watcher(Subscriber.new("Iris"))  # add first subscriber via class-specific method
sch.add_listener(Subscriber.new("Noah")) # add second subscriber via mixin method
sch.notify_listeners                     # trigger updates for all subscribers

# =========================================
# Module-level state per object (registry keyed by object_id)
# =========================================
module Registry
  def self.store                      # singleton hash shared by all includers
    @store ||= {}
  end

  def state=(value)                   # writer: set the current object’s state
    Registry.store[object_id] = value
  end

  def state                           # reader: get the current object’s state
    Registry.store[object_id]
  end
end

class Account
  include Registry                    # gain #state/#state=
end

acct = Account.new                    # first instance
puts acct.state = "Falcon"            # set & print its state
acct = Account.new                    # second instance (different object_id)
puts acct.state = "Wolf"              # independent state slot

p String.ancestors                    # show method lookup chain for String

# =========================================
# prepend vs include: method lookup order + super chaining
# =========================================
module Audit                          # will be PREPENDED → runs BEFORE class methods
  def execute
    puts "auditing"                   # do something first
    super                             # continue to next implementation in the chain
  end
end

module Dialer                         # will be INCLUDED → comes AFTER class methods
  def execute
    puts "dialing"                    # do something in the middle
    super                             # continue lookup
  end
end

class BaseUnit                        # base class at the end of the chain
  def execute
    puts "base work"                  # final behavior if no further super
  end
end

class Worker < BaseUnit
  prepend Audit                       # Audit#execute is placed before Worker#execute
  include Dialer                      # Dialer#execute is placed after Worker#execute

  def execute
    puts "worker running"             # class-level behavior
    super                             # go to Dialer#execute → BaseUnit#execute
  end
end

puts Worker.new("unused arg").execute # instantiate (arg ignored) and run the chain
# Expected order:
# auditing        (from Audit via prepend)
# worker running  (from Worker)
# dialing         (from Dialer via include)
# base work       (from BaseUnit)
