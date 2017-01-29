# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# zip_code.rb

# ZipCode model definitions, relationships, and validation behaviours

class ZipCode < ActiveRecord::Base
	# self.primary_key = "zip_code"
	
	has_one :state
	belongs_to :address
end
