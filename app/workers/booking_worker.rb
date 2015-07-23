class BookingWorker
  include Sidekiq::Worker

  def perform(booking_id,method)
    if method == "call_successful_payment_after_10_minutes"
      call_successful_payment_after_10_minutes(booking_id)
    elsif method == "schedule_job_for_car_booking"
      schedule_job_for_car_booking(booking_id)
    else
    end
  end


  def call_successful_payment_after_10_minutes(booking_id)
    booking = Booking.find_by_id(booking_id)
    booking.successful_payment!
  end

  def schedule_job_for_car_booking(booking_id)
    debugger
    booking = Booking.find_by_id(booking_id)
    booking.car_allocation!
  end


end
