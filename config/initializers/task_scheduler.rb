# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# task_scheduler.rb

# Run automated CRON jobs at specified intervals
require 'rubygems'
require 'rufus/scheduler'
require 'rake'

scheduler = Rufus::Scheduler.new

# on the last day of every month at 10:00 PM, run rake task
scheduler.cron '0 22 L * *' do
	# call rake task to disburse interest payments
	system("rake capstone:apply_savings_interest")
end