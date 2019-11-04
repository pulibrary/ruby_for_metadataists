require 'oci8'

def bib_ids_for_locations(locations)
  locations = OCI8.in_cond(:locations, locations)
  %(
    SELECT bib_master.bib_id
    FROM bib_master
      JOIN bib_mfhd
        ON bib_master.bib_id = bib_mfhd.bib_id
      JOIN mfhd_master
        ON bib_mfhd.mfhd_id = mfhd_master.mfhd_id
      JOIN location
        ON mfhd_master.location_id = location.location_id
    WHERE
      bib_master.suppress_in_opac = 'N'
      AND mfhd_master.suppress_in_opac = 'N'
      AND location.location_code IN (#{locations.names})
    GROUP BY bib_master.bib_id
    ORDER BY bib_master.bib_id
  )
end

def bulk_bib(bib_ids)
  bib_ids = OCI8.in_cond(:bib_ids, bib_ids)
  %(
  SELECT record_segment
  FROM bib_data
  WHERE bib_id IN (#{bib_ids.names})
  ORDER BY bib_id, seqnum
  )
end

def mfhds_for_bibs(bib_ids)
  bib_ids = OCI8.in_cond(:bib_ids, bib_ids)
  %(
    SELECT
     bib_mfhd.bib_id,
     record_segment
     FROM mfhd_data
      JOIN bib_mfhd
        ON mfhd_data.mfhd_id = bib_mfhd.mfhd_id
      JOIN mfhd_master
        ON bib_mfhd.mfhd_id = mfhd_master.mfhd_id
    WHERE
     bib_id IN (#{bib_ids.names})
     AND mfhd_master.suppress_in_opac = 'N'
     ORDER BY bib_mfhd.mfhd_id, seqnum
  )
end

def item_ids_for_mfhds(mfhd_ids)
  mfhd_ids = OCI8.in_cond(:mfhd_ids, mfhd_ids)
  %(
    SELECT
      mfhd_item.mfhd_id,
      item.item_id
    FROM item
      JOIN mfhd_item
        ON item.item_id = mfhd_item.item_id
    WHERE
      mfhd_item.mfhd_id IN (#{mfhd_ids.names})
  )
end

def item_info_for_item_ids(item_ids)
  item_ids = OCI8.in_cond(:item_ids, item_ids)
  %(
    SELECT
      item.item_id,
      perm_type.item_type_code,
      temp_type.item_type_code,
      item.create_date,
      item.modify_date,
      perm_loc.location_code,
      temp_loc.location_code,
      item.on_reserve,
      item_barcode.item_barcode,
      mfhd_item.item_enum,
      mfhd_item.chron,
      item.copy_number
    FROM item
      JOIN item_type perm_type
        ON item.item_type_id = perm_type.item_type_id
      JOIN location perm_loc
        ON item.perm_location = perm_loc.location_id
      JOIN mfhd_item
        ON item.item_id = mfhd_item.item_id
      LEFT JOIN item_barcode
        ON item.item_id = item_barcode.item_id
      LEFT JOIN item_type temp_type
        ON item.temp_item_type_id = temp_type.item_type_id
      LEFT JOIN location temp_loc
        ON item.temp_location = temp_loc.location_id
    WHERE item.item_id IN (#{item_ids.names})
  )
end
