require 'marc'
require_relative './dump_queries'

### Get bib IDs for an array of location codes
def get_bib_ids_for_locations(locations, conn)
  ids = []
  query = bib_ids_for_locations(locations)
  conn.exec(query, *locations) do |row|
    ids << row.first
  end
  ids
end

### Get MARC records contained in a Reader object for an array of bib IDs
def get_bib_coll(bib_ids, conn)
  segments = get_bib_coll_segments(bib_ids, conn)
  return nil if segments.empty?
  marc = segments.join('')
  MARC::Reader.new(StringIO.new(marc, 'r'),
                   external_encoding: 'UTF-8',
                   invalid: :replace,
                   replace: '')
end

def get_bib_coll_segments(bib_ids, conn)
  query = bulk_bib(bib_ids)
  segments = []
  conn.exec(query, *bib_ids) do |row|
    segments << row.first
  end
  segments
end

### Get a string of raw MARC for holdings attached to an array of bib IDs;
###   returns a hash with bib IDs as keys and the raw MARC as values
def get_mfhds_for_bib_coll(bib_ids, conn)
  query = mfhds_for_bibs(bib_ids)
  mfhds_with_keys = {}
  conn.exec(query, *bib_ids) do |row|
    bib_id = row.shift
    mfhd_data = row.shift
    mfhds_with_keys[bib_id] = [] unless mfhds_with_keys[bib_id]
    mfhds_with_keys[bib_id] << mfhd_data
  end
  mfhd_collection = {}
  mfhds_with_keys.each do |bib_id, mfhd_segments|
    mfhd_collection[bib_id] = mfhd_segments.join('')
  end
  mfhd_collection
end

### Get a hash of MFHD IDs with associated item IDs as values
def get_item_ids_for_mfhds(mfhd_ids, conn)
  results = {}
  mfhd_ids.each_slice(1000) do |segment|
    query = item_ids_for_mfhds(segment)
    conn.exec(query, *segment) do |row|
      mfhd_id = row.shift
      results[mfhd_id] = [] unless results[mfhd_id]
      item_id = row.shift
      results[mfhd_id] << item_id
    end
  end
  results
end

### Retrieve item info for an arbitary array of item IDs
def get_item_info_for_item_ids(item_ids, conn)
  items = {}
  item_ids.each_slice(1000) do |segment|
    query = item_info_for_item_ids(segment)
    conn.exec(query, *segment) do |row|
      item_id = row.shift
      items[item_id] = {}
      items[item_id][:perm_type] = row.shift
      items[item_id][:temp_type] = row.shift
      items[item_id][:create_date] = row.shift
      items[item_id][:mod_date] = row.shift
      items[item_id][:perm_loc] = row.shift
      items[item_id][:temp_loc] = row.shift
      items[item_id][:on_reserve] = row.shift
      items[item_id][:barcode] = row.shift
      enum = row.shift
      enum = valid_ascii(enum)
      items[item_id][:enum] = enum
      chron = row.shift
      chron = valid_ascii(chron)
      items[item_id][:chron] = chron
      items[item_id][:copy_num] = row.shift
    end
  end
  items
end

def remove_holding_item_fields_from_bib(bib)
  tags = %w[852 866 867 868 876]
  field_delete(tags, bib)
end

### merge desired fields from holding record into attached bib
def merge_holding_fields_into_bib(bib, holding)
  holding.fields.each_by_tag(%w[852 866 867 868]) do |field|
    field.subfields.unshift(MARC::Subfield.new('0', holding['001'].value))
    bib.append(field)
  end
  bib
end

def merge_enum_chron(enum, chron)
  if enum.nil?
    chron
  else
    string = enum
    string << " (#{chron})" if chron
    string.force_encoding('UTF-8')
    string.scrub!('')
    string.strip
  end
end

def append_item_fields(bib:, mfhd_id:, items:, item_ids:)
  return bib if item_ids.nil?
  mfhd_items = items.select { |item_id, _item_info| item_ids.include?(item_id) }
  mfhd_items.each do |item_id, item_info|
    item_field = item_field_from_info(
      mfhd_id: mfhd_id,
      item_id: item_id,
      info: item_info
    )
    bib.append(item_field)
  end
  bib
end

### merge holding fields and items into attached bib
def merge_holding_item_fields_into_bib(bib:, mfhds:, items:, item_ids_for_mfhds:)
  mfhd_reader = MARC::Reader.new(StringIO.new(mfhds))
  mfhd_reader.each do |mfhd|
    mfhd_id = mfhd['001'].value.to_i
    bib = merge_holding_fields_into_bib(bib, mfhd)
    item_ids = item_ids_for_mfhds[mfhd_id]
    bib = append_item_fields(
      bib: bib,
      mfhd_id: mfhd_id,
      items: items,
      item_ids: item_ids
    )
  end
  bib
end

def item_field_from_info(mfhd_id:, item_id:, info:)
  item_field = MARC::DataField.new('876', ' ', ' ')
  item_field.append(MARC::Subfield.new('0', mfhd_id.to_s))
  enum_chron = merge_enum_chron(info[:enum], info[:chron])
  item_field.append(MARC::Subfield.new('3', enum_chron)) if enum_chron
  item_field.append(MARC::Subfield.new('a', item_id.to_s))
  item_field.append(MARC::Subfield.new('p', info[:barcode])) if info[:barcode]
  item_field.append(MARC::Subfield.new('t', info[:copy_num].to_s))
  item_field.append(MARC::Subfield.new('x', info[:perm_loc]))
  item_field.append(MARC::Subfield.new('z', info[:temp_loc])) if info[:temp_loc]
  item_field
end

### Retrieve 001 values from a string of raw MARC
def get_ids_from_raw_marc(raw_marc)
  return raw_marc if raw_marc.nil?
  ids = []
  reader = MARC::Reader.new(StringIO.new(raw_marc))
  reader.each { |rec| ids << rec['001'].value.to_i if rec['001'] }
  ids
end

def get_merged_bibs(bib_ids, conn)
  merged_bibs = []
  bib_ids.each_slice(1000) do |segment|
    bibs = get_bib_coll(segment, conn)
    mfhd_data = get_mfhds_for_bib_coll(segment, conn)
    mfhd_ids = []
    mfhd_data.each_value do |raw_mfhds|
      mfhd_ids += get_ids_from_raw_marc(raw_mfhds)
    end
    item_ids_for_mfhds = get_item_ids_for_mfhds(mfhd_ids, conn)
    all_item_ids = []
    item_ids_for_mfhds.each_value { |ids| all_item_ids += ids }
    items = get_item_info_for_item_ids(all_item_ids, conn)
    bibs.each do |bib|
      bib_id = bib['001'].value.to_i
      mfhds = mfhd_data[bib_id]
      if mfhds
        bib = merge_holding_item_fields_into_bib(
          bib: bib,
          mfhds: mfhds,
          items: items,
          item_ids_for_mfhds: item_ids_for_mfhds
        )
      end
      bib = bad_utf8_fix(bib)
      merged_bibs << bib
    end
  end
  merged_bibs
end
