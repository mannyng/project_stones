# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# acct_type.rb

# AcctType model definitions, relationships, and validation behaviours
class AcctType < ActiveRecord::Base
	
	belongs_to :account
end
