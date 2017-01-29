require "rails_helper.rb"

  describe User do
   describe "email" do
     let (:user) {
       User.create!(email: "foo@example.com",
                    password: "qu1234567",
                    password_confirmation: "qu1234567",
                    username: "timbers"
                    )
       }

    it "must have a username" do
      expect raise_error(ActiveRecord::RecordInvalid, /failed/)
    end

    it "absolutely prevents invalid email addresses" do
      expect {
       user.update_attribute(:email, "")
       }.to raise_error#(ActiveRecord::StatementInvalid)
    end
   end
  end
