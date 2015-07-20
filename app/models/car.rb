class Car < ActiveRecord::Base
  has_many :carmovements
  has_many :carblocks
  belongs_to :car_group
  belongs_to :location
  as_enum :status, live: 0, banned: 1
end
