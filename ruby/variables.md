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

first_string + second_string
```

