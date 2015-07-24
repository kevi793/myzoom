class CarGroup < ActiveRecord::Base
  has_many :cars, dependent: :destroy
  has_many :inventories
  has_many :bookings
  has_many :carblocks
  has_many :carmovements
  has_one :price
end
