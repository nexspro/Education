# =========================================
# 1) Regex basics: =~ and match?
# =========================================
p /owl/                                   # literal regex that matches the substring "owl"
p /owl/ =~ "hawk and owl"                 # =~ returns the starting index of the first match (=> 9 here)
p /owl/ =~ "owlery"                       # finds "owl" at the start (index 0)
p /owl/ =~ "Owl"                          # case-sensitive: no match because capital "O"

p /owl/.match?("hawk and owl")            # match? returns true/false without creating a MatchData object
p /owl/.match?("owlery")                  # true because substring "owl" exists
p /owl/.match?("Owl")                     # false due to case sensitivity

p "hawk and owl" =~ /owl/                 # same check but with string on the left-hand side
p "owlery" =~ /owl/                       # returns 0 (match at beginning)
p "owlery".match?(/owl/)                  # boolean result → true
p "Owl" =~ /owl/                          # returns nil → no match

text = "owl and lynx"                     # sample string
if text.match?(/owl/)                     # check if pattern "owl" exists
  puts "We found an owl inside the text!" # output message when match is true
end

# =========================================
# 2) Regex with file iteration
# =========================================
logfile = File.join(__dir__, "testfile.txt")    # builds the path for a test file in the same folder

File.foreach(logfile).with_index do |line, idx| # iterate over file line by line with index
  puts "#{idx}: #{line}" if line.match?(/lynx/) # print lines containing the word "lynx"
end

File.foreach(logfile).with_index do |line, idx| # second pass over the file
  puts "#{idx}: #{line}" if line !~ /lynx/      # print lines NOT matching the regex "lynx"
end

# =========================================
# 3) sub / gsub (replace once vs replace all)
# =========================================
phrase = "Lynx and Owl"                   # original string
updated_once = phrase.sub(/Owl/, "Otter") # sub replaces the first occurrence only
puts "After sub: #{updated_once}"         # display result after single replacement

phrase = "Lynx and Owl"                   # reset the string
puts phrase.sub(/l/, "*")                 # sub replaces only the first lowercase "l"
puts phrase.gsub(/l/, "*")                # gsub replaces ALL lowercase "l"

phrase = "time moves swiftly"             # new string
phrase.sub!(/i/, "*")                     # sub! replaces first "i" in place
phrase.gsub!(/s/, "S")                    # gsub! replaces all "s" in place
puts phrase                               # final output after all replacements

# =========================================
# 4) Regex constructors
# =========================================

pattern = /dd\/yy/                          # literal regex for "dd/yy"
p pattern                                   # prints the regex itself
p Regexp.new("dd/yy")                       # constructor form using a string
p %r{dd/yy}                                 # alternate %r literal form

city_code_zip = %r{                         # multi-line regex with free-spacing (x flag)
  (\w.*),                                   # capture city name (any word characters and more)
  \s                                        # a whitespace
  ([A-Z]{2})                                # capture exactly 2 uppercase letters (state code)
  \s
  (\d{4,6})                                 # capture 4–6 digit zip/postal code
}x

p "Orlando, FL 32801".match?(city_code_zip) # test the multi-line regex against a sample string

# =========================================
# 5) Regex search with global vars
# =========================================
fullname = "Iris Monroe"                     # sample name string
p fullname =~ /i/                            # =~ returns index of first lowercase "i" (nil if none)
p fullname =~ /q/                            # no "q" → returns nil
p /i/ =~ fullname                            # same test with regex on the left side
p /i/.match(fullname)                        # explicit MatchData (or nil) for the first lowercase "i"
p Regexp.new("roe").match(fullname)          # dynamic regex built from string, matches "roe" at end

"Gliding over the meadow" =~ /mead/          # perform a match to populate Ruby’s global match vars
p $~                                         # $~ → last MatchData object
p $&                                         # $& → the exact matched substring
p $`                                         # $` → text before the match
p $'                                         # $' → text after the match

md = "Gliding over the meadow".match(/mead/) # capture MatchData in a local variable
p md                                         # print the MatchData object
p md[0]                                      # the full match (same as md.to_s)
p md.pre_match                               # substring before the match
p md.post_match                              # substring after the match

# =========================================
# 6) Helper: show_regexp
# =========================================
def show_regexp(str, pat)                      # helper that highlights the first match inside a string
  m = pat.match(str)                           # attempt to match the pattern against the string
  if m                                         # if a match occurred…
    "#{m.pre_match}->#{m[0]}<-#{m.post_match}" # …return a visual marker: before -> match <- after
  else                                         # if no match…
    "no match"                                 # …return a simple message
  end
end

p show_regexp("curious words", /r/)            # highlight first "r" in the string
p show_regexp("Iris Monroe", /roe/)            # highlight substring "roe"
p show_regexp("Iris Monroe", /q/)              # no match example
p show_regexp("yes | no", /\|/)                # match a literal pipe using escape
p show_regexp("yes (no)", /\(no\)/)            # match literal "(no)" by escaping parentheses
p show_regexp("unsure?", /e\?/)                # match a literal question mark by escaping it

# =========================================
# 7) Anchors and word boundaries
# =========================================
text = "this is\nthe moment"               # string with newline in middle
p show_regexp(text, /^the/)                # ^ anchor → "the" at start of a line
p show_regexp(text, /is$/)                 # $ anchor → "is" at end of string/line
p show_regexp(text, /\Athis/)              # \A anchor → "this" only at absolute start
p show_regexp(text, /\Athe/)               # fails because string starts with "this", not "the"
p "time's up".gsub(/\b/, "*")              # \b → word boundaries replaced with *
p "time's up".gsub(/\B/, "*")              # \B → non-boundaries replaced with *
p show_regexp(text, /\bis/)                # "is" at word boundary
p show_regexp(text, /\Bis/)                # "is" not at word boundary

p show_regexp("Price $ 42.", /[aeiou]/)    # first vowel in string
p show_regexp("Price $ 42.", /[0-9]/)      # first digit
p show_regexp("Price $ 42.", /[$.]/)       # match literal $ or .

snippet = "See [Page-42]"                  # sample with brackets and digits
p show_regexp(snippet, /[A-F]/)            # first uppercase A–F
p show_regexp(snippet, /[A-Fa-f]/)         # uppercase/lowercase A–F
p show_regexp(snippet, /[0-9]/)            # single digit
p show_regexp(snippet, /[0-9][0-9]/)       # two consecutive digits
p show_regexp("Price $42.", /[^A-Z]/)      # first non-uppercase letter
p show_regexp("Price $42.", /[^\w]/)       # first non-word char
p show_regexp("Price $42.", /[a-z][^a-z]/) # lowercase followed by non-lowercase
p show_regexp("It costs $42.", /\s/)       # first whitespace
p show_regexp("It costs $42.", /\d/)       # first digit
p show_regexp(snippet, /[\]]/)             # literal closing bracket
p show_regexp(snippet, /[0-9\]]/)          # either digit or closing bracket
p show_regexp(snippet, /[\d\-]/)           # digit or literal dash

# =========================================
# 8) Special chars and quantifiers
# =========================================
phrase = "It costs $42."            # sample with punctuation
p show_regexp(phrase, /c.s/)        # dot matches any char → "cos"
p show_regexp(phrase, /./)          # first char of string
p show_regexp(phrase, /\./)         # literal dot at end

line = "The sun is shining"         # sample text
p show_regexp(line, /\w+/)          # first word chars sequence
p show_regexp(line, /\s.*\s/)       # greedy → from first space to last space
p show_regexp(line, /\s.*?\s/)      # lazy → minimal match between spaces
p show_regexp(line, /[aeiou]{2,5}/) # 2–5 consecutive vowels
p show_regexp(line, /su?n/)         # optional "u" before "n"
p show_regexp(line, /su??n/)        # "u" optional but prefer no "u"
p show_regexp(line, /s*/)           # zero or more "s"
p show_regexp(line, /Z*/)           # zero or more "Z" (will match empty)

# =========================================
# 9) Alternation and grouping
# =========================================
colors = "red kite blue sky"                  # test string
p show_regexp(colors, /d|e/)                  # "d" or "e"
p show_regexp(colors, /ki|lu/)                # "ki" or "lu"
p show_regexp(colors, /red kite|angry sky/)   # whole alternations
p show_regexp("banana", /na+/)                # "n" followed by 1+ "a"
p show_regexp("banana", /(na)+/)              # one or more "na" groups
p show_regexp(colors, /blue|red/)             # "blue" or "red"
p show_regexp(colors, /(blue|red) \w+/)       # "blue"/"red" followed by a word
p show_regexp(colors, /(red|blue) \w+/)       # group alternation reversed
p show_regexp(colors, /red|blue \w+/)         # precedence difference
p show_regexp(colors, /red (kite|angry) sky/) # "red" followed by either group

# =========================================
# 10) Capturing groups
# =========================================

/(\d\d):(\d\d)(..)/ =~ "08:30am"                    # capture hour, minute, and AM/PM
p "Hour: #$1, Minute: #$2"                          # access global vars $1 and $2

/((\d\d):(\d\d))(..)/ =~ "08:30am"                  # outer + nested groups
p "Time: #$1"                                       # full time (08:30)
p "Hour: #$2, Minute: #$3"                          # inner groups
p "AM/PM: #$4"                                      # last group → "am"

md = /(\d\d):(\d\d)(..)/.match("08:30am")           # store MatchData
p "Hour: #{md[1]}, Minute: #{md[2]}"                # access by index

md = /((\d\d):(\d\d))(..)/.match("08:30am")
p "Time: #{md[1]}"                                  # outer group
p "Hour: #{md[2]}, Minute: #{md[3]}"                # inner groups
p "AM/PM: #{md[4]}"                                 # trailing group

# backreferences: \1 refers to first captured group
p show_regexp('She said "Hiiii"', /(\w)\1/)         # repeated single char
p show_regexp("banana", /(\w+)\1/)                  # repeated substring

sample = 'Look "noon"'
p show_regexp(sample, /(?<ch>\w)\k<ch>/)            # named backreference → repeated char

sample = "abracadabra"
p show_regexp(sample, /(?<seq>\w+)\k<seq>/)         # named backreference for substring

# named captures directly into variables
/(?<hh>\d\d):(?<mm>\d\d)(..)/ =~ "08:30am"
p "Hour is #{hh}, Minute #{mm}"                     # use named captures
p "Hour is #{hh}, Minute #{$2}"                     # mix with numeric backref

md = /(?<hh>\d\d):(?<mm>\d\d)(..)/.match("08:30am")
p "Hour: #{md[:hh]}, Minute: #{md[:mm]}"            # access by symbol keys

# =========================================
# 11) sub/gsub with blocks and replacements
# =========================================
txt = "swift brown hare"
p txt.sub(/[aeiou]/, "*")                                      # replace first vowel
p txt.gsub(/[aeiou]/, "*")                                     # replace all vowels
p txt.sub(/\s\S+/, "")                                         # remove first space + following word
p txt.gsub(/\s\S+/, "")                                        # remove all space+word sequences
p txt.sub(/^./) { |m| m.upcase }                               # uppercase first character
p txt.gsub(/[aeiou]/) { |v| v.upcase }                         # uppercase all vowels

# helper method to capitalize first letter of each word
def mixed_case(name)
  name.downcase.gsub(/\b\w/, &:upcase)
end
p mixed_case("NEW YORK")                                       # => "New York"
p mixed_case("new york")                                       # => "New York"
p mixed_case("nEw yOrK")                                       # => "New York"

# replacement using a hash map
map = { "lion" => "feline", "dog" => "canine" }
map.default = "unknown"
p "lion and dog".gsub(/\w+/, map)

# backreference in replacement strings
puts "john:doe".sub(/(\w+):(\w+)/, '\2, \1')                   # => "doe, john"
puts "swapme".gsub(/(.)(.)/, '\2\1')                           # swap every pair of chars

# named captures in replacement
puts "john:doe".sub(/(?<fn>\w+):(?<ln>\w+)/, '\k<ln>, \k<fn>')
puts "swapme".gsub(/(?<c1>.)(?<c2>.)/, '\k<c2>\k<c1>')

# escaping backslashes in replacement
esc = 'a\b\c'
p esc.gsub(/\\/, '\\\\\\\\')                                   # double escaping
p esc.gsub(/\\/, '\&\&')                                       # replace with match itself twice
p esc.gsub(/\\/) { '\\\\' }                                    # block form → insert literal "\\"