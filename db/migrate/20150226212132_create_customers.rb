class CreateCustomers < ActiveRecord::Migration
  def self.up
  	  # create CUSTOMERS table
	  create_table "customers", id: :uuid, id: false, default: "uuid_generate_v4()", force: true do |t|
	    t.integer "id",        limit: 8,  null: false
	    t.string  "phone1",    limit: 20
	    t.string  "phone2",    limit: 20
	    t.string  "title",     limit: 11
	    t.string  "firstname", limit: 40
	    t.string  "lastname",  limit: 40
	    t.uuid "user_id", default: "uuid_generate_v4()", null: false

	    t.timestamps
	  end
	  execute "ALTER TABLE customers ADD PRIMARY KEY (id);"
	  add_index "customers", ["lastname", "firstname"], name: "NAME_LAST_FIRST", using: :btree
	  add_index "customers", ["user_id"], name: "fk_customers_users1_idx", using: :btree
  end

  def self.down
  	drop_table :customers
  end
end
