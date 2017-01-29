class CreateAcctTransactions < ActiveRecord::Migration
  def self.up
  	# create ACCT_TRANSACTIONS table
	  create_table "acct_transactions", id: false, force: true do |t|
	    t.integer  "id",                  limit: 8,                            null: false
	    t.datetime "date",                                                     null: false
	    t.text     "description",         limit: 255
	    t.decimal  "amount",                          precision: 10, scale: 2, null: false
	    t.integer  "account_id",          limit: 8,                            null: false
	    t.integer  "transaction_type_id",                                      null: false
	    t.decimal "adjusted_bal",                		precision: 10, scale: 2, null: false
	  
	    t.timestamps
	  end
	  execute "ALTER TABLE acct_transactions ADD PRIMARY KEY (id);"
	  add_index "acct_transactions", ["account_id"], name: "fk_acct_transactions_accounts1_idx", using: :btree
	  add_index "acct_transactions", ["date", "id"], name: "BY_DATE", using: :btree
	  add_index "acct_transactions", ["transaction_type_id"], name: "fk_acct_transactions_transaction_types1_idx", using: :btree
  end

  def self.down
  	drop_table :acct_transactions
  end
end
