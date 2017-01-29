class WireTransfer < ActiveRecord::Base

  belongs_to :acct_transaction

   validates :recipient_name, presence: true
end
