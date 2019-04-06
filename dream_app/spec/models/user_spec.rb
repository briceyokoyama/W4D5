require 'rails_helper'

RSpec.describe User do
  describe "validations" do
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_presence_of(:session_token)}
    it {should validate_length_of(:password).is_at_least(6)}
  end

  describe "associations" do
  end

  describe "methods" do
    subject(:user)  { User.create!(username: "jimmy12", password: "jimmy12")}

    describe "::find_by_credentials" do
      it "finds the correct user if username and password match" do
        expect(User.find_by_credentials(user.username, user.password)).to eq(user)
      end
    end

    describe "#password=" do
      it "encrypts the password" do
        #password does not exist
        expect(user.password).should be_nil
        #password_digest != password
        expect(user.password_digest).to_not eq(user.password)
      end
    end

    describe "#is_password?" do
      it "returns true if password is correct" do
        expect(user.is_password?("jimmy12")).to be_true
      end

      it "returns true if password is correct" do
        expect(user.is_password?("jimmy13")).to be_false
      end
    end

    describe "#reset_session_token!" do
      it "resets the user's session_token" do
        sess_token = user.session_token
        user.reset_session_token!
        expect(user.session_token).to_not eq(sess_token)
      end
    end
  end
end