# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# administrator.rb

# Administrator model definitions, relationships, and validation behaviours

class Administrator < ActiveRecord::Base
	
	belongs_to :user
	
end
