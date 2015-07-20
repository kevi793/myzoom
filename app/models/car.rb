class Car < ActiveRecord::Base
  has_many :carmovements
  has_many :carblocks
  has_many :bookings
  belongs_to :car_group
  belongs_to :location
end
