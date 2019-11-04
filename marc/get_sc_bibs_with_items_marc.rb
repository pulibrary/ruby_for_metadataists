require_relative './dump_methods'
require_relative './format_methods'

### Create array of all locations of interest; taken from Don's spreadsheet
sc_locations = %w[
  beac
  cook
  ctsn
  ctsnrf
  ed
  ex
  exb
  exc
  exca
  exf
  exho
  exi
  exka
  exki
  exl
  exme
  exov
  expa
  exrc
  exrl
  extr
  extsf
  exv
  exw
  ga
  garf
  gax
  hsvc
  hsve
  hsvg
  hsvm
  hsvn
  hsvp
  hsvr
  hsvw
  htn
  map
  mss
  mudd
  mudf
  njpg
  num
  numrf
  pb
  prnc
  ptt
  rcppg
  rcpph
  rcpxc
  rcpxg
  rcpxm
  rcpxn
  rcpxp
  rcpxr
  rcpxw
  rht
  thx
  thxr
  vrg
  w
  wa
  warf
  whs
  wit
]

### Establish ODBC connection to Voyager
conn_file = File.size?('./../tmp/conn.yml') ? './../tmp/conn.yml' : './conn.yml'
stanza = YAML.load_file(conn_file)
conn = OCI8.new(stanza['user'], stanza['pass'], stanza['name'])

### Get bib IDs of interest
bib_ids = get_bib_ids_for_locations(sc_locations, conn)

### Export merged bibs, allowing for oversized records
merged_writer = MARC::Writer.new('./all_sc_bibs_with_holdings_items.mrc')
merged_writer.allow_oversized = true

### Also export unmerged bibs
unmerged_writer = MARC::Writer.new('./all_sc_bibs.mrc')
bib_ids.each_slice(1000) do |segment|
  merged_bibs = get_merged_bibs(segment, conn)
  merged_bibs.each { |bib| merged_writer.write(bib) }
  unmerged_bibs = get_bib_coll(segment, conn)
  unmerged_bibs.each { |bib| unmerged_writer.write(bib) }
end
merged_writer.close
unmerged_writer.close
