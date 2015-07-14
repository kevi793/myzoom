require 'faker'
FactoryGirl.define do
  factory :user do
    f.name {Faker::Name.first_name}
  end

end
