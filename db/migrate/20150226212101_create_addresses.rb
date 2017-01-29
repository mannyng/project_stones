class CreateAddresses < ActiveRecord::Migration
  def self.up
  	# create ADDRESSES table
	  create_table "addresses", id: false, force: true do |t|
	    t.integer "customer_id",       limit: 8,  null: false
	    t.string  "address1", default: {}, limit: 100, null: false
	    t.string  "address2", default: {}, limit: 100
	    t.string  "zip_code_zip_code", limit: 5,  null: false    
	  end
	  execute "ALTER TABLE addresses ADD PRIMARY KEY (customer_id);"
	  add_index "addresses", ["zip_code_zip_code"], name: "fk_addresses_zip_codes1_idx", using: :btree
  end

  def self.down
  	drop_table :addresses
  end
end
