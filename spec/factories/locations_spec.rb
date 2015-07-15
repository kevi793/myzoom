require 'faker'
FactoryGirl.define do
  factory :location do |l|
    l.name {Faker::Address.city}
    l.address {Faker::Address.street_address}
    l.latitude {Faker::Address.latitude}
    l.longitude {Faker::Address.longitude}
    l.map_link {Faker::Internet.url}
    l.description {Faker::Address.street_address}
  end
end
