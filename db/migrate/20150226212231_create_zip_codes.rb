class CreateZipCodes < ActiveRecord::Migration
  def self.up
  	# create ZIP_CODES table
	  create_table "zip_codes", id: false, force: true do |t|
	    t.string  "zip_code", limit: 5,  null: false
	    t.string  "city",     limit: 45, null: false
	    t.string "state_abbreviation", limit: 3, null: false
	  end
	  execute "ALTER TABLE zip_codes ADD PRIMARY KEY (zip_code);"
	  add_index "zip_codes", ["state_abbreviation"], name: "fk_zip_codes_states1_idx", using: :btree
  end

  def self.down
  	drop_table :zip_codes
  end
end
