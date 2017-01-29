class CreateAdministrators < ActiveRecord::Migration
  def self.up
  	# create ADMINISTRATORS table
	create_table "administrators", id: :uuid, id: false, default: "uuid_generate_v4()", force: true do |t|
	    t.integer "id",        limit: 8,  null: false
	    t.string  "firstname", limit: 40, null: false
	    t.string  "lastname",  limit: 40, null: false
	    t.uuid    "user_id", default: "uuid_generate_v4()", null: false
	  
	    t.timestamps
	  end
	  execute "ALTER TABLE administrators ADD PRIMARY KEY (id);"
	  add_index "administrators", ["lastname", "firstname", "id"], name: "BY_LASTNAME", using: :btree
	  add_index "administrators", ["user_id"], name: "fk_administrators_users_idx", using: :btree
  end

  def self.down
  	drop_table :administrators
  end
end
