class User < ActiveRecord::Base
  attr_accessor :name
  attr_accessor :email
  validates :name, presence: true
  validates :email, presence: true
end
