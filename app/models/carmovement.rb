class Carmovement < ActiveRecord::Base
  belongs_to :location
  belongs_to :car
  belongs_to :car_group

  scope :get_cars, lambda { |car_group_id, location_id, start_time, end_time|
    where("car_group_id = ? and location_id = ? and start_time <= ? and end_time >= ?",
    car_group_id, location_id, start_time, end_time)
  }

  scope :get_current_or_future_movements , lambda { |current_time|
    where("end_time > ?",current_time)
  }
  
end
