# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# account.rb

# Account model definitions, relationships, and validation behaviours

class Account < ActiveRecord::Base
	belongs_to :customer
	belongs_to :user
	has_one :acct_type
	has_many :acct_transactions, :dependent => :destroy
        has_many :recipient_details, :dependent => :destroy

	accepts_nested_attributes_for :acct_type
	accepts_nested_attributes_for :acct_transactions

	validates :acct_type_id, presence: true

end
