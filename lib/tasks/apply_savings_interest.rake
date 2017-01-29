# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# apply_savings_interest.rake

namespace :capstone do 
	desc "Compute monthly interest for savings accounts, add to account as new acct_transaction"
	task :apply_savings_interest  => :environment do
		# Find all savings accounts and begin iteration
		Account.where("acct_type_id = 1").find_each do |account|
		# Get balance and calculate the interest
		unless account.balance <= 0.00
			@interest = account.balance * 0.0099
			# Create new transaction to disburse interest payment to account
				AcctTransaction.create! do |transaction|
					transaction.id = SecureRandom.random_number(99999999999999)
					transaction.account_id = account.id
					transaction.transaction_type_id = 8
					transaction.description = "Interest Payment"
					transaction.amount = @interest
					transaction.adjusted_bal = account.balance + @interest
					transaction.date = Time.now
				# Update the account balance
				account.update(balance: transaction.adjusted_bal)
				end
			end
		end
	puts "Interest has been disbursed to savings accounts."
	end
end