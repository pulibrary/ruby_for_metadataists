require 'marc'

### Error detection

## Find indicators that are non-numeric
def invalid_indicators?(record)
  record.fields.each do |field|
    next unless field.class == MARC::DataField
    return true unless field.indicator1 =~ /^[0-9 ]$/ && field.indicator2 =~ /^[0-9 ]$/
  end
  false
end

## Find discrepancies between variable fields and their 880 pairings
def pair_880_errors?(record)
  pair_880s = []
  linked_fields = []
  return false unless record['880']
  record.fields.each do |field|
    return true if field.tag == '880' && field['6'].nil?
    next unless field.tag =~ /^[0-8]..$/ && field.class == MARC::DataField && field['6']
    if field.tag == '880'
      pair_880s << field['6'].gsub(/^([0-9]{3}-[0-9]{2}).*$/, '\1')
    else
      linked_fields << "#{field.tag}-#{field['6'].gsub(/^880-([0-9]{2}).*$/, '\1').chomp}"
    end
  end
  pair_880s.delete_if { |x| x =~ /^.*-00/ }
  return true if pair_880s.uniq != pair_880s || pair_880s.uniq.sort != linked_fields.uniq.sort
  false
end

## List of non-repeatable fields taken from the MARC standard
def non_repeatable_fields
  %w[
    001
    003
    005
    008
    010
    018
    036
    038
    040
    042
    043
    044
    045
    066
    100
    110
    111
    130
    240
    243
    245
    254
    256
    263
    306
    310
    357
    384
    507
    514
    841
    842
    844
    882
  ]
end

## Identify records where non-repeatable fields are repeated
def repeatable_field_errors?(record)
  field_count = record.fields.group_by(&:tag).map { |key, value| { tag: key, count: value.size } }
  nr_fields = field_count.select { |item| non_repeatable_fields.include?(item[:tag]) && item[:count] > 1 }
  !nr_fields.empty?
end

## Identify records with empty subfields
def empty_subfields?(record)
  record.fields.each do |field|
    next unless field.class == MARC::DataField
    field.subfields.each do |subfield|
      return true if subfield.value =~ /^[[:blank:]]*$/
    end
  end
  false
end

### Record fixes

## Remove empty subfields from DataFields
def empty_subfield_fix(record)
  fields_to_delete = []
  curr_field = -1
  record.fields.each do |field|
    curr_field += 1
    next unless field.class == MARC::DataField
    curr_subfield = 0
    subfields_to_delete = []
    field.subfields.each do |subfield|
      subfields_to_delete.unshift(curr_subfield) if subfield.value.empty? || subfield.value.nil?
      curr_subfield += 1
    end
    subfields_to_delete.each do |i|
      record.fields[curr_field].subfields.delete_at(i)
    end
    fields_to_delete.unshift(curr_field) if record.fields[curr_field].subfields.empty?
  end
  unless fields_to_delete.empty?
    fields_to_delete.each do |i|
      record.fields.delete_at(i)
    end
  end
  record
end

## Can delete fields based on tags alone, or with
##   optional indicator values provided in arrays
def field_delete(record, tags, indicators = {})
  if indicators.empty?
    record.fields.delete_if { |field| tags.include? field.tag }
  else
    ind_1 = indicators[:ind_1]
    ind_2 = indicators[:ind_2]
    if ind_1 && ind_2
      record.fields.delete_if { |field| (tags.include? field.tag) && (ind_1.include? field.indicator1) && (ind_2.include? field.indicator2) }
    elsif ind_1
      record.fields.delete_if { |field| (tags.include? field.tag) && (ind_1.include? field.indicator1) }
    else
      record.fields.delete_if { |field| (tags.include? field.tag) && (ind_2.include? field.indicator2) }
    end
  end
  record
end


### Count fields in a record; set :subfields to True to drill down to subfields
def field_count(record, opts = {})
  results = {}
  if opts[:subfields]
    record.fields.each do |field|
      tag = field.tag.scrub('')
      case tag
      when /^00/
        results[tag] = 0 unless results[tag]
        results[tag] += 1
      else
        field.subfields.each do |subfield|
          key = tag + subfield.code.to_s.scrub('')
          results[key] = 0 unless results[key]
          results[key] += 1
        end
      end
    end
  else
    record.fields.each do |field|
      tag = field.tag.scrub('')
      results[tag] = 0 unless results[tag]
      results[tag] += 1
    end
  end
  results
end

f880_errors = []
empty_subfields = []
repeated_fields = []
indicator_errors = []
reader = MARC::Reader.new('./sample.mrc')
reader.each do |record|
  f880_errors << record if pair_880_errors?(record)
  empty_subfields << record if empty_subfields?(record)
  repeated_fields << record if repeatable_field_errors?(record)
  indicator_errors << record if invalid_indicators?(record)
end

### Sample fix
test_rec = empty_subfields.first

## before record
puts test_rec

## introduce an empty subfield
test_rec.fields('050').first.subfields[1].value = ''
puts test_rec

## fixes
field_delete(test_rec, %w[902 904])
empty_subfield_fix(test_rec)

## after record
puts test_rec
