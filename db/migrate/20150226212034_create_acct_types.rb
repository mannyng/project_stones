class CreateAcctTypes < ActiveRecord::Migration
  def self.up
  	# create ACCT_TYPES table
	  create_table "acct_types", force: true do |t|
	    t.string  "name",          limit: 14
	    t.decimal "interest_rate",            precision: 3, scale: 3, default: 0.0, null: false
	  end
  end

  def self.down
  	drop_table :acct_types
  end
end
