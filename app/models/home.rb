class Home < ActiveRecord::Base
 require 'kitco'

  def self.gold
    Kitco.gold
  end

  def self.platinum
    Kitco.platinum
  end

  def self.silver
   Kitco.silver
  end

  def self.palladium
    Kitco.palladium
  end

  def self.rhodium
    Kitco.rhodium
  end

end
