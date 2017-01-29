class CreateUsers < ActiveRecord::Migration
  def self.up
  	# create USERS table
	  create_table "users", id: :uuid, id: false, default: "uuid_generate_v4()", force: true do |t|
	   t.uuid "id", default: "uuid_generate_v4()", null: false, unique: true
	    t.string  	"username", 	limit: 30, default: "", null: false
	    t.string  	"password", 	limit: 30, default: "", null: false   
	    t.string 	"role", 		limit: 30, default: nil

	    t.timestamps
	  end
	  execute "ALTER TABLE users ADD PRIMARY KEY (id);"
	  add_index "users", ["username", "id"], name: "BY_USERNAME", using: :btree
  end

  def self.down
  	drop_table :users
  end
end
