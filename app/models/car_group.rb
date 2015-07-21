class CarGroup < ActiveRecord::Base
  has_many :cars, dependent: :destroy
  has_many :inventories
  has_many :bookings
end
