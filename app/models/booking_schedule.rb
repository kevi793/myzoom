class BookingSchedule < ActiveRecord::Base
  belongs_to :booking
  def self.add(booking_id, start_time, end_time)
    BookingSchedule.create(:booking_id => booking_id, :start_time => start_time, :end_time => end_time)
  end
end
