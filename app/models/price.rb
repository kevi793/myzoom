class Price < ActiveRecord::Base

  def self.get_id(car_group_id, city_id, booking_created_at, booking_start_time)
    price_id = Price.where("car_group_id = ? and city_id = ? and created_at <= ? and start_time <= ?",
    car_group_id, city_id, booking_created_at, start_time).order(start_time: :asc).last.pluck(:id)
    price_id.first
  end

end
