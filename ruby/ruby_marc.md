# Ruby for Metadataists
## MARC and Ruby

The `ruby-marc` Gem provides an API for reading and writing MARC record fields.
Developed as an open source project, this provides a few methods through which
to parse and process the value of MARC record fields.

# Parsing MARC
Reading from a MARC record file is quite straightforward.  One simple constructs
a `MARC::Reader` object with the file system path:

```ruby
reader = MARC::Reader.new('ruby/4609321.dat', external_encoding: "UTF-8")
```

One is then able to iterate through the records using the following method:

```ruby
reader.each do |record|
  # Retrieves the values within the 245 field
  puts record['245']
  # Retrieves the value of the 245$a subfield
  puts record['245']['a']
end
```

You may also generate an Array from the `MARC::Reader` containing the records:

```ruby
records = reader.to_a
```

Please be aware that one cannot retrieve the Array of records more than once
from a reader.  After reading the records, the buffer for the file is closed:

```ruby
records = reader.to_a
duplicate_records = reader.to_a
records.length
duplicate_records.length
```

Alternatively, one is also able to parse MARC-XML records:
```ruby
reader = MARC::XMLReader.new('ruby/4609321.xml')
```

## Accessing MARC Leaders

Accessing the MARC leader is relatively straightforward, as there exists a
`leader` method:
```ruby
records = reader.to_a
first_record = records.first
first_record.leader
```

## Accessing MARC Field Data

Fields are accessed using the MARC tags as one would keys for Hashes:
```ruby
records = reader.to_a
first_record = records.first
marc_field = first_record["700"]
```

### Control Fields
Control fields are provided with their own first-order Class, but are retrieved
simply by selecting the appropriate control tags:

```ruby
control_field = first_record["008"]
control_field.tag
 => "008"
control_field.value
 => "051027s1456    gw            000 0 lat d"
```

Fields contain the following attributes storing the tag, two indicators, and the
subfields:
```ruby
marc_field.tag
 => "700"
marc_field.value
 => "Gutenberg, Johann,1397?-1468,printer.http://id.loc.gov/authorities/names/n50034916"
marc_field.indicator1
 => "1"
marc_field.indicator2
 => " "
marc_field.subfields
```

### MARC Subfields

The tag and indicators are consistently strings, while the subfields are modeled
as their own Classes:

```ruby
subfields = marc_field.subfields
subfield = subfields.first
```

`Subfield` Classes contain attributes for both the `code` and `value` of the
subfield.  Both of these should consistently be strings.

```ruby
subfield.code
 => "a"
subfield.value
 => "Gutenberg, Johann,"
```

## MARC Conversion to Hashes

One is able to parse and manipulate MARC records as one would with Hashes using
the following:

```ruby
records = reader.to_a
first_record = records.first
first_record.to_hash
```

The MARC Hash has two keys "leader" and "fields".  For the "leader" values, the
leader itself is a string:
```ruby
marc_values = first_record.to_hash
marc_values["leader"]
"03283cam a22003975a 4500"

marc_fields = marc_values["fields"]
marc_fields.first
```

### Writing MARC Records to Files

Using a `MARC::Record` Object, there are two fairly straightforward approaches
to writing MARC records in a file:

```ruby
reader = MARC::Reader.new('ruby/4609321.dat', external_encoding: "UTF-8")
records = reader.to_a
first_record = records.first

writer = MARC::Writer.new('new_marc_record.dat')
writer.write(first_record)
writer.close()
```

It is also possible to write the MARC record in XML:

```ruby
xml_writer = MARC::XMLWriter.new('new_marc_record.mrx')
xml_writer.write(first_record)
xml_writer.close()
```

