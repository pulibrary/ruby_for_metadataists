# The Ruby Programming Language
## Control Flow Statements

Control flow statements structure the logical progression of a given Ruby script
or application.  Whereas variables are used to store and manipulate state, the
control flow statements permit one to express the conditions under which
variables are set and updated, as well as precisely how these variables may be
changed over time.

### Conditionals

`if`, `else`, `elsif`, and `unless` are the primary keywords through which one expresses
a conditional in Ruby.  These typically include the usage of comparison
operators:

| Operator | Usage                    |
| -------- | ------------------------ |
| `>`      | Greater than             |
| `<`      | Less than                |
| `>=`     | Greater than or equal to |
| `<=`     | Less than or equal to    |
| `==`     | Equal to                 |
| `!=`     | Not equal to             |

*Note: For the purposes of demonstrating conditionals, `puts` is a method
which prints a String.  This will be used to demonstrate that a condition is
reached.*

```ruby
my_var1 = 10

if my_var1 > 9 do
  puts "my_var1 is greater than 9"
end
```

`else` provides additional branching for cases where the initial condition is
not met:

```ruby
my_var2 = 10

if my_var2 < 9 do
  puts "my_var2 is less than 9"
else
  puts "my_var2 is greater than 9"
end
```

More conditionals may be provided using the `elsif` branching, leading to more
complex trees:

```ruby
my_var3 = 10

if my_var3 < 9 do
  puts "my_var3 is less than 9"
elsif my_var3 == 11
  puts "my_var3 is 11"
elsif my_var3 > 11
  puts "my_var3 is greater than 11"
else
  puts "my_var3 is 10"
end
```

Comparison operators are not the only operators which may be used in
conditionals, as there are also boolean operators which may be used to modify
logical statements:

| Operator | Usage       |
| -------- | ----------- |
| `&&`     | Logical AND |
| `\|\|`     | Logical OR  |

```ruby

my_var4 = 20
my_var5 = 30

if my_var4 > 10 && my_var5 < 40
  puts "my_var 4 is greater than 10 and my_var5 is less than 40"
end
```

`unless` is used as `if`, but carries with it an implied negation of a condition:

```ruby
my_var6 = 40

unless my_var6 < 40
  puts "my_var6 is 40 or greater"
end
```

The constructions for these conditionals thus far have taken a form in which
`if` is followed by a condition, with the procedure to be run, and then an `end`
 keyword.  If the procedure to be run is only a single line, however, a
single-line construction can instead be offered:

```ruby
my_var7 = 50
puts "my_var7 is greater than 40" if my_var7 > 40
```

### Iterating

Building off of what was discussed for Arrays and Hashes in the earlier
discussion addressing variables, Ruby provides language features which permits
one to sequentially process the elements of an Array, or the key/value pairs
within a Hash.

The most straightforward way of approaching this is the usage of the `each`
method on any Array:

```ruby
my_set1 = [1,2,3]

my_set1.each do |element|
  puts "This is the current element in the iteration: #{element}"
end
```

There are a number of details for this which should be noted.  Firstly, one uses
the `.` character in order to call the `each` method.  The meaning of the term
"method" and the usage of `.` will be discussed later when we provide an
overview for Classes and Objects.  Also, one uses the `do` keyword here in
 order to initiate a `block` in Ruby.  Not unlike what was seen earlier with the
`if` conditionals, within these `blocks` there are procedures which perform on
 the element within the current iteration.

The argument passed to the `block` is provided is wrapped in pipe characters
(`|`).  This may be different if one is iterating on something other than an
 Array, for example, a Hash:

```ruby
my_struct = { color: 'blue', shape: 'round' }

my_struct.each do |key, value|

  puts "This is the current key: #{key}"
  puts "This is the current value: #{value}"
end
```

For the case of Hashes, `each` uses a block which has two arguments: the key and
the value for each pair in the Hash.

An alternative notation for iterating through Hashes and Arrays is to use curly
brackets (`{}`) as opposed to the `do` and `end` keywords.  This is helpful if
the procedure within the block only consumes one line of space:

```ruby

my_set1 = [1,2,3]

my_set1.each { |element| puts "Current element: #{element}" }
```

Both approaches are valid, however the usage of curly brackets is a bit less
wieldy and more difficult to read.

One may also control iterations using the `next` keyword in order to
handle certain conditions:

```ruby
my_set1 = [1,2,3]

my_set1.each do |element|
  next if element == 2
  puts "This is the current element in the iteration: #{element}"
end
```

In this example, if the current element is `2`, then the iteration will skip to
the next element without any further procedures.

### Loops

Ruby also offers features supporting loops for iterating through a sequence of
values offered by an Array or Hash.  These use the `while` and `until` keywords:

```ruby
i = 0

while i < 10
  i = i + 1
end
puts "The loop has finished"
```

As was the case with `if` and `unless`, `until` provides an implicit negation of
a condition which would normally be provided to `while`:

```ruby
i = 0

until i >= 10
  i = i + 1
end
puts "The loop has finished"
```

In both of these examples, the loop is executed until the condition provided to
`while` or `until` is fulfilled.  Here, the variable `i` is incremented by `1`
until it is equal to `10`.

