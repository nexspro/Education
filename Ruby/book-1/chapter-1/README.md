# Chapter 1: Hello World & Ruby Basics

## What I Did

- Wrote a small Ruby script that prints messages to STDOUT.

- Defined a sum(a, b) method to show how + works with different types (numbers vs. strings).

- Demonstrated string interpolation using Time.now.

- Showed whitespace trimming with String#strip (including tabs/CRLF). 

### Key Concepts

- Polymorphic +: Integer + Integer → arithmetic; String + String → concatenation; mixing types raises TypeError.

- String Interpolation: "The time is #{Time.now}" embeds evaluated Ruby expressions in strings.

- Whitespace Trimming: String#strip removes leading/trailing spaces, tabs, and newline characters.

- Duck Typing: Behavior depends on the receiver’s methods (any object implementing #+ can be used with sum). 
