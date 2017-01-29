# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# customer.rb

# Customer model definitions, relationships, and validation behaviours

class Customer < ActiveRecord::Base

	belongs_to :user, :dependent => :destroy
	has_one :address, :dependent => :destroy
	has_many :accounts, :dependent => :destroy

	validates :phone1, :firstname, :lastname, presence: true
	validates_format_of :phone1, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/

	# validates_format_of :phone2, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/

	accepts_nested_attributes_for :accounts, :allow_destroy => true
	accepts_nested_attributes_for :address, :allow_destroy => true
end
