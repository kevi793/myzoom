class BookingWorker
  include Sidekiq::Worker

  def perform(booking_id,method)
    if method == "call_successful_payment_after_10_minutes"
      debugger
      booking = Booking.find_by_id(booking_id)
      booking.successful_payment!
    end
  end

end
