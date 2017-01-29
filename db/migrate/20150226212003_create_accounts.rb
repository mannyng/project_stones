class CreateAccounts < ActiveRecord::Migration
  def self.up
  	# create ACCOUNTS table
	  create_table "accounts", id: false, force: true do |t|
	    t.integer "id",           limit: 8,                          null: false
	    t.decimal "balance",                precision: 10, scale: 2, null: false
	    t.datetime    "date_opened",                                     null: false
	    t.integer "customer_id",  limit: 8,                          null: false
	    t.integer "acct_type_id", limit: 1,                          null: false
	  
	    t.timestamps
	  end
	  execute "ALTER TABLE accounts ADD PRIMARY KEY (id);"
	  add_index "accounts", ["acct_type_id"], name: "fk_accounts_acct_types1_idx", using: :btree
	  add_index "accounts", ["customer_id"], name: "fk_accounts_customers1_idx", using: :btree
  end

  def self.down
  	drop_table :accounts
  end
end
