require 'faker'
FactoryGirl.define do
  factory :city do |c|
    c.name {Faker::Address.city}
  end
end
