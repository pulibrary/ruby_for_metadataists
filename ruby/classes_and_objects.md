# Ruby for Metadataists
## Classes and Objects

Until this point, we have discussed some of the more basic features of the Ruby
language.  While Ruby offers a number of what were previously termed data types,
Ruby is indeed an object-oriented programming language.  As such, Ruby provides
developers and users with the ability to define their own data types, with their
own custom behavior, using Classes.

Classes provide a prototype for any data type within Ruby, and define a name for
the data type.  While Classes are prototypal, each discrete declaration within 
a Ruby script or program results in an Object.  Hence, the Class is essentially
the "type" of Object, while Objects themselves are instances of the custom data
types.

Defining a Class is performed using the `class` keyword.  Classes may be
extremely trivial:

```ruby
class MyType

end
```

A new Object is constructed using the following syntax:

```
my_object = MyType.new
```

While this Class is valid, it is more or less useless.  In order to model
something in the real world, Classes can be defined using two features: a
constructor and instance variables.  A constructor is a type of method, which
shall be discussed in greater detail:

```ruby
class Car

  def initialize(make, model, year)
    @make = make
    @model = model
    @year = year
  end
end
```

Now Objects are constructed using the following syntax:

```ruby
my_car = Car.new('Toyota', 'Camry', 2015)
```

The constructor method `initialize` defines the arguments and behavior of the
`.new` method which is used to construct a new Object.  Here, there are three
arguments: `make`, `model`, and `year`.  Should one attempt to construct a `Car`
Object without specifying all three of these, then an error will be raised:

```ruby
my_car2 = Car.new('Toyota')
```

Within the body of the constructor, one can see that there are three special
variables with the `@` character.  This indicates that they are instance
variables.  Instance variables are variables which contain values which defined
the state of the Object.  These are shared between methods on any given Class.
In order to clarify this, please see the following example:

```ruby
class Car

  def initialize(make, model, year)
    @make = make
    @model = model
    @year = year
  end

  def get_year()
    return @year
  end
end
```

Now we have defined `Car` with an additional, custom method using the `def`
keyword.  This returns the value of the `@year` instance variable:

```ruby
my_car3 = Car.new('Toyota', 'Prius', 2016)
my_car3.get_year()
```

This demonstrates the usage of instance variables: they are accessible from
within *any* method.  Methods may also modify instance variables:

```ruby
class Car

  def initialize(make, model, year)
    @make = make
    @model = model
    @year = year
  end

  def get_year()
    return @year
  end

  def add_year()
    @year = @year + 1
  end
end
```

```ruby
my_car4 = Car.new('Mazda', 'Miata', 2014)
my_car4.get_year()
my_car4.add_year()
my_car4.get_year()
```

As one can see, the `add_year` method simply modifies the instance variable.
Also note that the `return` keyword is explicitly used in the `get_year` method
in order to return the value of `@year`.

#### Important Point Regarding Ruby

Until this point, one may have noticed that the syntax used to invoke methods on
Objects has involved the usage of the `.` character.  This should seem familiar
from the previous lessons, this is how we invoked the `each` method on Arrays
and Hashes.

There is a reason for this, and that is because Arrays and Hashes are also
Objects.  In fact *every data type in Ruby has its own Class.*  Hence, Arrays,
Hashes, Strings, and even regular expressions (`Regexp` is the name of the
 Class) are, in fact, Classes.  Hence:

`[1,2,3]` is an Object
`"My string"` is an Object
`123.456` is an Object

The `.class` method which was referenced in the first lesson is simple a method
which returns the Class for any Object in Ruby.

#### Returning to Classes

There are cases in which one may seek to reference the Object itself from within
a Class.  This is performed using the `self` keyword:

```ruby
class Car

  def initialize(make, model, year)
    @make = make
    @model = model
    @year = year
  end

  def get_year()
    return @year
  end

  def add_year()
    @year = @year + 1
  end

  def get_make()
    return @make
  end

  def get_model()
    return @model
  end

  def get_make_and_model()
    return self.get_make() + " " + self.get_model()
  end
end
```

Here, the `get_make_and_model` method invokes both the internal methods
`get_make` and `get_model` using the `self` keyword.

#### Ruby Idioms

Up until this point, we have provided method definitions in a very explicit
manner.  However, method definitions need not be so well structured in Ruby:

```ruby
class Car

  def initialize(make, model, year)
    @make = make
    @model = model
    @year = year
  end

  def get_year
    @year
  end

  def add_year
    @year = @year + 1
  end

  def get_make
    @make
  end

  def get_model
    @model
  end

  def get_make_and_model
    get_make + " " + get_model
  end
```

As seen above, it is not necessary to provide parentheses for method definitions
when no arguments are specified.  Further, for those cases, invoking the method
also does not require the usage of parentheses.

Additionally, please note that the keywords `self` and `return` are, in most
cases, unnecessary and unused.  Methods implicitly return the value of the last
statement within the method body.
