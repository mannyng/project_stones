# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# transaction_type.rb

# TransactionType model definitions, relationships, and validation behaviours

class TransactionType < ActiveRecord::Base
	belongs_to :acct_transaction
        belongs_to :recipient_detail
end
