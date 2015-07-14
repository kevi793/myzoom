require 'rails_helper'

RSpec.describe User, type: :model do
  it "should not give error if name exists" do
    user = FactoryGirl.create(:user)
    user.should be_valid
  end
end
