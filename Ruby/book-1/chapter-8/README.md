# Chapter 8: Regular Expressions

## What I did
- Practiced with **basic regex** using `=~` and `match?`, comparing string vs regex on left-hand side.  
- Used regex inside **conditionals** to detect patterns in strings.  
- Applied regex to **file iteration**, filtering lines that match (or don’t match) a given pattern.  
- Compared **`sub` vs `gsub`** for single vs global replacements, including in-place (`sub!`, `gsub!`).  
- Created regex using **literals**, `Regexp.new`, and `%r{}` syntax.  
- Built **multiline regex** with the `x` flag for readability (capturing city, state, zip).  
- Explored **global regex variables** (`$~`, `$&`, $`, $'`) and captured matches with `MatchData`.  
- Wrote a **helper method** `show_regexp` to visualize matches in context with arrows.  
- Practiced **anchors** (`^`, `$`, `\A`), **word boundaries** (`\b`, `\B`), and shorthand classes (`\d`, `\s`, `\w`).  
- Tested **character classes**: ranges (`[A-F]`), negations (`[^A-Z]`), escaped characters (`[\]]`), and shorthand (`\d`, `\s`).  
- Experimented with **special characters and quantifiers** (`.`, `?`, `*`, `{m,n}`), greedy vs lazy matching (`.*` vs `.*?`).  
- Used **alternation and grouping** (`|`, `(...)`) to combine multiple patterns.  
- Worked with **capturing groups** for hours/minutes (both numbered and named captures).  
- Explored **backreferences** (`\1`, `\k<name>`) for repeated patterns in strings.  
- Applied **named captures** directly into variables and via `MatchData`.  
- Used `sub`/`gsub` with **hash maps** for word replacement and with **blocks** for dynamic substitution.  
- Practiced **escaping** backslashes in replacement strings with different strategies.

## Key Concepts
- **Regex basics**: `=~`, `match?`, difference between boolean vs index return.  
- **File scanning**: line filtering with regex inside iteration.  
- **Replacement methods**: `sub` vs `gsub`, single vs global, destructive (`!`) vs non-destructive.  
- **Regex construction**: literals, `Regexp.new`, `%r{}` syntax, extended mode (`x`).  
- **Match data**: global variables (`$~`, `$&`, etc.) and `MatchData` object.  
- **Anchors & Boundaries**: `^`, `$`, `\A`, `\b`, `\B`.  
- **Character classes**: ranges `[a-z]`, negations `[^...]`, shorthand `\d`, `\s`, `\w`.  
- **Quantifiers**: `?`, `*`, `+`, `{m,n}`, greedy vs lazy.  
- **Alternation & Grouping**: `|`, parentheses for grouping.  
- **Captures**: numbered groups, named groups, and backreferences.  
- **Dynamic replacements**: blocks and hash-based substitutions.  
- **Escaping**: careful handling of backslashes in regex and replacement strings.  
