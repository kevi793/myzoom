class Price < ActiveRecord::Base
  has_many :price_details, dependent: :destroy

  enum day_type: {
    weekday: 0,
    weekend: 1
  }


  def self.calculate(car_group_id, booking_time, start_time, end_time)
    debugger
    price_plan = getPricePlan(car_group_id, booking_time, start_time)
    duration = end_time.to_i - start_time.to_i
    number_of_weeks = duration/(1.week.to_i)
    duration = duration % (1.week.to_i)
    number_of_days = duration/(1.day.to_i)
    duration = duration % (1.day.to_i)
    number_of_hours = duration/(1.hour.to_i)
    number_of_hours = number_of_hours + 1 if duration % (1.hour.to_i) == 0
    number_of_weeks*price_plan[:fare_per_week]+number_of_days*price_plan[:fare_per_day]+number_of_hours*price_plan[:fare_per_hour]

  end

  def type_of_day(date_time)
    debugger
    if date_time.wday<5
      Price.day_type[:weekday]
    else
      Price.day_type[:weekend]
  end

  def getPricePlan(car_group_id, booking_time, start_time)
    debugger
    price_id = Price.where("car_group_id = ? and created_at <= ? and start_time <= ? and day_type = ?",
    car_group_id, booking_time, start_time, type_of_day(start_time)).order(start_time: :asc).last.pluck(:id)
    PriceDetail.find_by_price_id(price_id[0])
  end


end
