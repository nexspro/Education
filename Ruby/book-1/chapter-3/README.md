# Chapter 3: Objects, CSV & Encapsulation

### Requirements  
- Install the `csv` gem before running the scripts:  
  ```bash
  gem install csv

### What I did
- Defined a `ProductItem` class with attributes, formatting, and price conversion helpers.  
- Implemented a `StockImporter` class to load items from CSV files and compute totals.  
- Used `ARGV` to process command-line arguments for dynamic CSV file loading.  
- Created demo usage for `ProductItem` (discounts, cents conversion, printing).  
- Practiced method visibility (`public`, `protected`, `private`) with multiple class styles.  
- Built a `Wallet` and `Transfer` system to demonstrate encapsulation and object interaction.  
- Explored object references, duplication (`dup`), and immutability (`freeze`).  
- Reopened a class (`Document`) to add new behavior.  
- Extended a core class (`String`) with a `squish` method.  
- Wrote a utility class (`TextTools`) with a class method alternative to `squish`.  

### Key Concepts
- **CSV parsing**: using Ruby’s `CSV.foreach` with headers.  
- **Classes & objects**: constructors, attributes, custom `to_s`.  
- **Value objects**: storing and formatting data safely.  
- **Encapsulation**: `protected` attributes vs. public methods.  
- **Method visibility**: `public`, `protected`, `private` usage patterns.  
- **Command-line arguments**: handling with `ARGV`.  
- **Object references**: shared references, duplication (`dup`), immutability (`freeze`).  
- **Reopening classes**: extending existing classes by reopening them.  
- **Core extensions vs utilities**: adding methods to core (`String#squish`) vs. standalone utility class (`TextTools.squish`).  
