require "rails_helper.rb"

  describe AcctTransaction do
   describe "adjusted_bal" do
     let (:acct_transaction) {
       AcctTransaction.create!(amount: "500",
                    description: "Wilshire homes"
                    )
       }

    it "must have an amount" do
      expect(acct_transaction).to be_valid
    end
    it "will validate numericality of amount" do
     expect{acct_transaction.update(amount: "ture")}.to
     raise_error(ActiveRecord::RecordInvalid,
       /Validation failed: Amount is not a number/)
    end
  
  end
  
 end
