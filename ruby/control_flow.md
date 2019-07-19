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

