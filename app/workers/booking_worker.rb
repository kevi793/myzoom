class BookingWorker
  include Sidekiq::Worker

  def perform(booking_id,method)
    if method == "call_successful_payment"
      call_successful_payment(booking_id)
    elsif method == "schedule_job_for_car_booking"
      book_car(booking_id)
    else

    end
  end


  def call_successful_payment(booking_id)
    booking = Booking.find_by_id(booking_id)
    booking.successful_payment!
  end

  def book_car(booking_id)
    booking = Booking.find_by_id(booking_id)
    available_car_ids = Carmovement.get_cars(booking.car_group_id, booking.location_id, booking.start_time, booking.end_time).pluck(:car_id)
    available_car_ids -= Booking.cars_in_use(booking.car_group_id, booking.location_id, DateTime.now()).pluck(:car_id)
    available_car_ids -= Carblock.cars_blocked(booking.car_group_id, booking.start_time, booking.end_time)
    booking.car_id = available_car_ids.first
    booking.save
    booking.car_allocation!
  end

end
