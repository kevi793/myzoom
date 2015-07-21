class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :car
  belongs_to :car_group
  belongs_to :location


end
