# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# home_controller.rb

# This controller defines the HomeController as a child of the ApplicationController
class HomeController < ApplicationController
 require 'kitco'

   def index
    @gold = Kitco.gold
    @silver = Home.silver
    @platinum = Kitco.platinum
    @palladium = Kitco.palladium
    @rhodium = Kitco.rhodium
   end

   def about
   end

end
