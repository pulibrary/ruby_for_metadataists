# Ruby for Metadataists
## Modules and Namespaces

While Ruby offers one the ability to organize code using Classes, there may be
cases where one wishes to logically group methods without structuring them into
a Class.  Ruby offers a separate feature for this, a Module:

```ruby
module Writable
  def write(stream)
    @buffer << stream
  end
end

module Readable
  def read
    @buffer
  end
end

class FileHandle
  include Writable
  include Readable

  def initialize(buffer)
    @buffer
  end
end
```

Using Modules, one can define methods outside of Class definitions, and include
these using the `include` keyword.  Please note that Module methods can operate
on instance variables even when divorced from Class definitions declaring these.

Modules may also be used to declare constants:

```ruby
module Trig
  PI = 3.141592654
end
```

Constants are declared using variable names in using upper case characters.
They are accessed within a Module using the `::` operator:

```ruby
puts Trig::PI
```

Within this context, the Module name is said to be namespacing the constants.
Modules may also be used to namespace Class definitions as well:

```ruby
module Bibliographic

  class Book

    def initialize(title)
      @title = title
    end
  end
end
```

With this namespace, one would then construct a `Book` Object by invoking the
following:

```ruby
Bibliographic::Book.new('À la recherche du temps perdu')
```
