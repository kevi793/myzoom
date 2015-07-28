class PricingVersion < ActiveRecord::Base
  has_many :bookings
  scope :get_id, lambda{ |booking_time|
    where("start_time <= ?",booking_time).last.id
  }

end
