# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# address.rb

# Address model definitions, relationships, and validation behaviours
class Address < ActiveRecord::Base
	belongs_to :customer
	belongs_to :user

	has_one :zip_code
	has_one :state, through: :zip_code

	accepts_nested_attributes_for :zip_code, :allow_destroy => false
	accepts_nested_attributes_for :state, :allow_destroy => false	

	validates :zip_code_zip_code, presence: true
	validates :address1, presence: true
	validate :check_zip

  def check_zip
    if ZipCode.where(:zip_code => zip_code_zip_code).blank?
      errors.add(:base, 'Not a real zip code')
	else
	# Zip Code is valid
	end
  end
end
