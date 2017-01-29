require "rails_helper.rb"

  describe WireTransfer do
   describe "bank_account" do
     let (:wire_transfers) {
       WireTransfer.create!(recipient_name: "Joh Hand"
                    )
       }

    it "must have a username" do
      expect(:wire_transfers).to raise_error
    end
 
  end
 end
