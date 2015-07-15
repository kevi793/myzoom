require 'faker'
FactoryGirl.define do
  factory :city do |c|
    c.name {Faker::Name.first_name}
  end
end
