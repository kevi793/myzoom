class Pricingv1

#
#   BUFFER_TIME = 30
#   WEEKDAY_DISCOUNT = 10
#   WEEKEND_EXTRA_CHARGE_PERCENTAGE = 10
#
#   RESCHEDULE_BUFFER_TIME = 60
#   RESCHEDULE_CHARGE_PERCENTAGE_WITHIN_ONE_DAY_OF_START_TIME = 40
#   RESCHEDULE_CHARGE_PERCENTAGE_WITHIN_TWO_DAYS_OF_START_TIME = 30
#   RESCHEDULE_CHARGE_PERCENTAGE_BEFORE_TWO_DAYS_OF_JOURNEY = 20
#
#   CANCELLATION_CHARGE_PERCENTAGE_WITHIN_ONE_DAY_OF_START_TIME = 40
#   CANCELLATION_CHARGE_PERCENTAGE_WITHIN_TWO_DAYS_OF_START_TIME = 30
#   CANCELLATION_CHARGE_PERCENTAGE_BEFORE_TWO_DAYS_OF_JOURNEY = 20
#
#   def self.reschedule
#
#   end
#
#
#   def self.check(booking)
#     if booking.booking_status < 7
#       if !booking.actual_end_time.blank?
#         if booking.actual_end_time > booking.end_time + BUFFER_TIME.minutes
#           booking.late = true
#         elsif booking.actual_end_time < booking.end_time - BUFFER_TIME.minutes
#           booking.early = true
#         end
#       else
#       end
#     else
#     end
#   end
#
#
#
#
#   def self.cancel
#   end
#
#   def self.mis
#   end
#
#
#   def self.get_fare(start_time, end_time, actual_start_time, actual_end_time)
#     data = {weeks: 0, days: 0, hours: 0, fare_per_week: 0,
#     fare_per_day: 0, fare_per_hour: 0}
#     duration = end_time.to_i - start_time.to_i
#     data[:weeks] = duration/(1.week.to_i)
#     duration = duration % (1.week.to_i)
#     data[:days] = duration/(1.day.to_i)
#     duration = duration % (1.day.to_i)
#     data[:hours] = duration/(1.hour.to_i)
#     data[:hours] = data[:hours] + 1 if duration % (1.hour.to_i) == 0
#
#     #discount
#
#
#     data[:fare_per_week] = data[:weeks]*booking.fare_per_week.to_f
#     data[:fare_per_day] = data[:days]*booking.fare_per_day.to_f
#     data[:fare_per_hour] = data[:hours]*booking.fare_per_hour.to_f
#
#
#
#   end
#
end
