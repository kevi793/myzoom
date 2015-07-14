require 'faker'
FactoryGirl.define do
  factory :user do
    f.name {Faker::Name.first_name}
    f.email {Faker::Internet.email}
  end

end
