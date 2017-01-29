# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# acct_transaction.rb

# Definitions and validations pertaining to the AcctTransaction model
class AcctTransaction < ActiveRecord::Base
	
    belongs_to :account
    has_one :transaction_type
    has_many :wire_transfers
       
       accepts_nested_attributes_for :wire_transfers, :allow_destroy => true    
	accepts_nested_attributes_for :transaction_type, :allow_destroy => false
	validates_numericality_of :amount
	validate :funds_availability

  def self.deposit(account, amount)
    puts "Depositing #{amount} on account #{account.id}"
    return false unless self.amount_valid?(amount)
    account.balance = (account.balance += amount).round(2)
    account.save!
  end

  def self.withdraw(account, amount)
    puts "Withdrawing #{amount} on account #{account.id}"
    return false unless self.amount_valid?(amount)
    account.balance = (account.balance -= amount).round(2)
    account.save!
  end

  def self.transfer(account, recipient, amount)
    puts "Transfering #{amount} from account #{account.id} to account #{recipient.id}"
    return false unless self.amount_valid?(amount)
    ActiveRecord::Base.transaction do
      self.withdraw(account, amount)
      self.deposit(recipient, amount)
    end
  end


	def funds_availability
		if self.transaction_type_id == 7 && self.amount > Account.find(self.account_id).balance
			errors.add(:amount, 'INSUFFICIENT FUNDS!! Please try again')
		end
	end
end
