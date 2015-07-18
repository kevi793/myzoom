require 'rails_helper'

RSpec.describe User, type: :model do
  it "should not give error if name exists" do
    user = FactoryGirl.create(:user)
    user.should be_valid
  end

  describe "remember me " do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have a remember_me! method" do
      expect(@user).to respond_to(:remember_me!)
    end

    it "should set the remember token" do
      expect(@user).to respond_to(:remember_token)
    end

    it "should have a remember token " do
      @user.remember_me!
      expect(@user).not_to be_nil
    end

  end

end
