class Carblock < ActiveRecord::Base
  belongs_to :car
  belongs_to :locations
  belongs_to :car_group

  scope :before_time, lambda {|car_group_id, given_time|
    where("car_group_id = ? and end_time <= ?",car_group_id, given_time)
  }

  scope :after_time, lambda{|car_group_id, given_time|
    where("car_group_id = ? and start_time >= ?",car_group_id, given_time)
  }

  def self.cars_blocked(car_group_id, start_time, end_time)
    carblocks = Carblock.all.pluck(:car_id)
    carblocks -= Carblock.after_time(car_group_id, start_time)
    carblocks -= Carblock.before_time(car_group_id, end_time)
  end

end
