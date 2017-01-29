# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# state.rb

# State model definitions, relationships, and validation behaviours

class State < ActiveRecord::Base
	belongs_to :zip_code
end
