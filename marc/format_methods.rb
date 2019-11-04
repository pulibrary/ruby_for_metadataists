### Conversion to Unicode for enum/chron info
def valid_ascii(string)
  return string if string.nil?
  string.force_encoding('ascii')
  string.encode!('UTF-8', invalid: :replace, replace: '')
  string.scrub('')
end

### Scrub invalid UTF8 from record
def bad_utf8_fix(record)
  record.fields.each do |field|
    if field.class == MARC::DataField
      field.subfields.each do |subfield|
        subfield.value.force_encoding('UTF-8')
        subfield.value.scrub!('')
      end
    else
      field.value.force_encoding('UTF-8')
      field.value.scrub!('')
    end
  end
  record
end
