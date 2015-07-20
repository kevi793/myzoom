class Inventory < ActiveRecord::Base
  belongs_to :car_group
  belongs_to :city
  belongs_to :location

  scope :search, lambda do |location_id, start_time, end_time|
    where(["location_id = ? and start_time <= ? and end_time >= ?",location_id, start_time, end_time])
  end

end
