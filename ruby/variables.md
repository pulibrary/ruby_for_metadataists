# The Ruby Programming Language
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
 - Strings
 - Numbers
 - Arrays
 - Hashes
 - Regular expressions

It should be noted here, however, that Ruby is a dynamically-typed language.  As
such, variables are not strictly bound to any data type.  In other words, a
variable may be declared and assigned a String value, but then later assigned a
Number value.

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


