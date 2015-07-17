require 'faker'
FactoryGirl.define do
  factory :user do |f|
    f.first_name 'John'
    f.last_name 'Cena'
    f.email 'example@gmail.com'
    f.password 'password'
  end
end
