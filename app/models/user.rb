class User < ActiveRecord::Base
  validates :first_name,
            :presence => {:message => "firstname cannit be blank"},
            :length => {in: 2..25, :message => 'Must be between 2 to 25 characters'}

  validates :last_name,
            :presence => {:message => "firstname cannit be blank"},
            :length => {in: 2..25, :message => 'Must be between 2 to 25 characters'}

  validates :email,
            :presence => {:message => "email cannit be blank"},
            :length => {maximum: 100, :message => 'Must be less than 100 characters'},
            :email => true,
            :uniqueness => {:message => "email already exists"}

  has_secure_password

end
