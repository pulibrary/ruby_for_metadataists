# Ruby for Metadataists
## Variables

Variables are used to store and manipulate values throughout an application or
script.  This is a feature essential to all programming languages:

```ruby
my_name = "Alice"
puts "Hello #{my_name}"
my_name = "Bob"
puts "Hello #{my_name}"
```

Variables are declared and assigned by providing the name of the variable,
followed by the assignment operator `=`.

There are various data types offered for variables in Ruby, and for the purposes
of this workshop, we are only going to provide an overview of the following:
 - Nil
 - Strings
 - Numbers
 - Booleans
 - Arrays
 - Hashes
 - Symbols
 - Regular expressions

It should be noted here, however, that Ruby is a dynamically-typed language.  As
such, variables are not strictly bound to any data type.  In other words, a
variable may be declared and assigned a String value, but then later assigned a
Number value.

*Note: For the purposes of introducing data types in Ruby, one may inspect the
type of value using the `.class` method on any value:*
```ruby
"my string".class
```
*The meaning and syntax of this will be explained later when we discuss Classes
and Objects.*

### Nil

`nil` is a value which indicates a lack of value.  It is distinct from `false`,
as it may indicate a variable has not been declared.  For those familiar with
C-based languages, this is analogous to `null`.

### Strings

Strings are a data type which provide users with the ability to store a sequence
of characters (a "character string").  These may or may not be terminated with a
newline and/or carriage return:

```ruby

first_string = "foo"
second_string = "bar"
```

Strings may be concatenated with the `+` operator:

```ruby

third_string = first_string + second_string
```

Strings may also be inserted within larger strings using the language feature
known as interpolation:

```ruby
str1 = "red"
str2 = "blue"
"#{str1} and #{str2}"
```

This is used by enclosing a larger string within double quotes (`"`) and wrapping
the variable names within the sequence the operator sequence `#{` ... `}`.

## Numbers

Ruby stores numbers using a variety of data types, all of which support standard
arithmetic operations.

Integers alone (regardless of sign) are stored using `Fixnum` types, while more
precision could be found using the `Float` or `Complex` types:

```ruby

33.class
7.8.class
3.to_c.class
```

Arithmetic operations

Addition:

```ruby
u + v
```

Subtraction:

```ruby
u - v
```

Multiplication:

```ruby
u * v
```

Division:

```ruby
u / v
```

Exponentiation:

```ruby
u ** v
```

Modulo (Remainder after division):

```
u % v
```

It should be noted that the more precise data type takes precedence, and forces
a conversion between less precise types.  For example:

```ruby
result = 22.0 / 7
result.class
```

In addition to these operators, there are also cases where one may
simultaneously perform arithmetic operations while (re)assigning the value to a
variable.

| Operator | Function |
| +=       | Add a value to an existing variable and reassign it to the sum |
| -=       | Subtract a value from an existing variable and reassign it to the result |
| *=       | Multiply a value with an existing variable and reassign it to the product |
| /=       | Divide a value with an existing variable and reassign it to the quotient |
| %=       | Modulo a value with an existing variable and reassign it to the remainder |
| **=      | Raise an existing value to an exponent and reassign it to the product |

## Booleans

Boolean values model cases where the state is either explicitly true or false.
The values themselves are either `true` or `false`.

## Arrays

Arrays are variables which contain ordered sets of variables.  Arrays do not
need an explicitly defined length, and may be declared using the following
syntax:

```ruby
my_set = [1,2,3]
```

Arrays may contain variables of various types, and as such, may have mixed data
types within the set:

```ruby
second_set = ["foo", 5, "bar", 6.0]
```

Navigating the elements of an Array can be achieved through a number of methods.
There are straightforward approaches which Ruby provides such as:

```ruby
second_set.first
second_set.last
```

However, it must be recalled here that Arrays have an implicit order, and as
such, each element has an integer (and index) referring to its position within
that Array.  The index for an element is 0-based (hence, the first element in an
Array is always 0):

```ruby
second_set[0]
second_set[1]
```

Negative indices may be used to count backwards from the end of the Array:

```ruby
second_set[-1]
second_set[-2]
```

Should one attempt to access an element in an Array which is out of range, this
will simply return a `Nil` value:

```ruby
second_set[99]
```

One may also attempt to access subsets of elements within an Array using the
following syntax:

```ruby
second_set[0,2]
```

Please note here that the second element in the subset is exclusive, and hence
need to be 1 more than the index of the last element in order to include it in
the results.

It should be noted that there is another operator which can be used to append
elements to the end of an Array.  This may be executed with the following:

```ruby
third_set = [1,2,3]
third_set << 4
```

## Hashes

While Arrays contain elements which are ordered, Ruby also provides a separate
data type which may contain elements which are unordered, and instead associated
with a keyword.  These are Hashes, and are often used to represent complex data
structures:

```ruby
my_hash = { 'color' => 'blue', 'weight' => 'heavy' }
```

In the above example, this Hash would contain the keys `color` and `weight`.  In
order to retrieve the value associated with each of these keys, one uses
brackets (much like with Arrays):

```ruby
my_hash['color']
my_hash['weight']
```

Keys and values in Hashes may be of any data type:

```ruby
my_hash[2.3] = 3.4
```

Each key is unique, and hence, setting a value multiple times with a same key
overrides the value:

```ruby
my_hash[2.3] = 4.5
my_hash[2.3]
my_hash[2.3] = 5.6
my_hash[2.3]
```

## Symbols

Symbols represent a data type commonly used within Hashes, and essential
represent a single, unchangeable value.  While working with Strings as Hash keys
is possible, Strings encapsulate much more information (such as case or length),
and as such, it is often quite faster to use a symbol:

```ruby
my_hash[:color] = 'red'
```

From the standpoint of memory management, Symbols can increase speed and
efficiency when it comes to the storage and retrieval of values from within
Hashes.  There is also shorthand syntax available for declaring Hash values when
using Symbols for keys:

```ruby
my_hash = { :color => 'red'  }
my_hash2 = { color: 'red' }
```

Please note that this syntax *only* applies to cases when Symbols are used as
keys.

## Regular Expressions

Regular Expressions are, themselves, a formal language which are used to encode 
a pattern used to extract information from text.  Like many other programming 
languages, Ruby offers support for the usage of regular expressions in the 
parsing and extracting of information stored within Strings.  The syntax of
Regular Expressions follows a fairly [standardized 
form](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html),
however the adaptation for Ruby is a bit more 
[customized](http://ruby-doc.org/core-2.6.3/Regexp.html).

A regular expression is formed using the following:

```ruby
/hay/.match('haystack')
```

If the search for 'hay' is found within the target string, this will yield a
`MatchData` object as a result.  If this cannot be found, it will yield a `nil`:

```ruby
/foo/.match('haystack')
```

Regular expressions become more powerful when metacharacters are used.  Three
metacharacters which may be employed are `*`, `.`, and `?`.

`*` indicates that the preceding character must be repeated 0 or more times.  
For example:

```ruby
/re*d/.match('red')
/re*d/.match('reed')
/re*d/.match('yard')
```

In all cases the `*` finds a match.  In the first case `e` is found once, in the
second, it is found twice.  For the third case, the `e` is optional for the
match.

`.` indicates that the preceding character must be repeated 1 or more times.  
For example:


```ruby
/re.d/.match('read')
/re.d/.match('red')
/re.d/.match('reed')
/re.d/.match('yard')
```

In these examples, the first and third matches are successful, while the second
and fourth are not.  `red` does not repeat `e` at least once, and `yard` simply
does not contain `e` following any `r`.

`?` indicates that the preceding character must be repeated 0 or 1 times (no
greater):

```ruby
/chee?s/.match('cheese')
/chee?s/.match('chess')
/chee?s/.match('cheeese')
```

For this example, only the first two matches are successful, as the second `e`
character is basically just considered to be optional.  Any more than one
repetition and the match will fail.

