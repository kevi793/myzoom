require 'rails_helper'

RSpec.describe City, type: :model do
  city = FactoryGirl.create(:city)
  context "when a city is created" do
    it "is valid" do
      city.should be_valid
    end
  end
end
