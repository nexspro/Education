# Exercise 3 Classes, Objects & Visibility

### What I did
Built a `ProductItem` class with price handling (cents conversion, safe updates).  
Created a `StockImporter` to read `Code,UnitPrice` from CSV and compute totals.  
Used command-line arguments (`ARGV`) to load one or multiple CSV files.  
Demonstrated method visibility with `public`, `protected`, and `private` methods.  
Implemented a `Wallet` with encapsulated balance and a `Transfer` to move funds safely.  
Explored object references vs. copies (`dup`) and immutability with `freeze`.  
Reopened a `Document` class to add `uppercase_title`.  
Extended core `String` with a `squish` method and built a `TextTools.squish` helper.  
Added small demos to validate each concept.

### Key Concepts
Classes & objects as reusable blueprints (`ProductItem`, `Wallet`, `Document`).  
CSV processing with `CSV.foreach`, strict headers (`Code`, `UnitPrice`), and aggregation.  
Command-line arguments (`ARGV`) for file input in CLI programs.  
Method visibility: `public` (everywhere), `protected` (class/subclasses), `private` (receiverless).  
Encapsulation: hide state (`balance`), expose intent (`deposit!`, `withdraw!`, `execute`).  
Object references: shared mutation vs. independent copies with `dup`.  
Immutability: `freeze` prevents further modifications (raises `FrozenError` on change).  
Open classes: safely adding methods to existing classes (`Document`, `String#squish`).  
Utility classes: grouping class-level helpers (`TextTools.squish`).
