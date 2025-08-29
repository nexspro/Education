# Chapter 7: Numbers, Strings & Ranges

## What I did
- Practiced with **integer literals** in multiple forms: decimal, hex (`0x`), octal (`0o`), binary (`0b`), negatives, and large numbers with underscores for readability.  
- Used **BigDecimal** for precise decimal arithmetic beyond floating-point limitations.  
- Explored **Rationals** via literals (`3/5r`), constructors (`Rational(3, 5)`), and conversions from strings.  
- Worked with **Complex numbers** from literals (`2+3i`), strings (`"2+3i".to_c`), and constructors.  
- Iterated over arrays of numbers, splitting into digits and computing digit sums.  
- Observed **numeric promotion rules** when mixing Integers, Floats, Rationals, and Complex numbers.  
- Compared **division variants** (`/`, `to_f`, `fdiv`) and their differences in return types.  
- Practiced **integer iterators** (`times`, `upto`, `downto`, `step`) and used `with_index` for indexed iteration.  
- Explored **string syntax**: single vs double quotes, interpolation, `%q/%Q` literals, and adjacent literal concatenation.  
- Built multiline strings with **heredocs** (`<<`, `<<~`, multiple heredocs) and checked encodings with `String#encoding`.  
- Created a **Track class** to parse catalog data into objects, with song lengths stored as strings and converted into seconds.  
- Practiced **ranges**: inclusive vs exclusive (`..` vs `...`), converting ranges to arrays, and slicing arrays (`[..2]`, `[2..]`).  
- Built a **custom range endpoint** class (`Doubling`) implementing `<=>` and `succ` to define stepwise growth.  
- Compared **range membership checks**: `===`, `include?`, `cover?` for values and strings.  
- Used **case statements with ranges** to classify numeric values by interval.

## Key Concepts
- **Numbers**: integer literals with different bases, BigDecimal, Rationals, Complex.  
- **Numeric promotion**: automatic type promotion when mixing arithmetic operations.  
- **Division methods**: `/` (context-sensitive), `to_f`, `fdiv`.  
- **Iteration**: integer iterators (`times`, `upto`, `downto`, `step`), indexed iteration.  
- **Strings**: interpolation, concatenation, `%q/%Q` forms, heredocs, encoding.  
- **Classes & Objects**: parsing text into structured objects (`Track`).  
- **Ranges**: inclusive vs exclusive, slicing arrays, converting to enumerators.  
- **Custom Range Endpoints**: implementing `<=>` and `succ` to extend range behavior.  
- **Membership Operators**: `===` for case equality, `include?` for actual elements, `cover?` for bound checks.  
- **Case with Ranges**: simple, readable interval classification.  
