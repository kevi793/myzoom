class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :car
  belongs_to :car_group
  belongs_to :location
  has_many :booking_status_time_stamps

  include AASM

  enum booking_status: {
    initiated: 1,
    awaiting_payment: 2,
    paid: 3,
    allocated: 4,
    checkout: 5,
    completed: 6,
    cancelled: 7
  }

  aasm :column => :booking_status, :enum => true do

      state :initiated, initial: true
      state :awaiting_payment
      state :paid
      state :allocated
      state :checkout
      state :completed
      state :cancelled

      event :start_payment do
        transitions :from => :initiated , :to => :awaiting_payment, :after => :set_booking_status_changes
      end

      event :successful_payment do
        transitions :from => :awaiting_payment , :to => :paid, :after => :set_booking_status_changes
      end

      event :car_allocation do
        transitions :from => :paid, :to => :allocated, :after => :set_booking_status_changes
      end

      event :checkout do
        transitions :from => :allocated, :to => :checkout, :after => :set_booking_status_changes
      end

      event :completed do
        transitions :from => :checkout, :to => :completed, :after => :set_booking_status_changes
      end

      event :cancellation_from_initiated do
        transitions :from => :initiated, :to => :cancelled, :after => :set_booking_status_changes
      end

      event :cancellation_from_paid do
        transitions :from => :paid, :to => :cancelled, :after => :set_booking_status_changes
      end

      event :cancellation_from_allocated do
        transitions :from => :allocated, :to => :cancelled, :after => :set_booking_status_changes
      end

      event :cancellation_from_checkout do
        transitions :from => :checkout, :to => :cancelled, :after => :set_booking_status_changes
      end

  end


  def payment_successful?
    true
  end

  def set_booking_status_changes
    booking_status_time_stamp = BookingStatusTimeStamp.create()
    booking_status_time_stamp.booking_id = self.id
    booking_status_time_stamp.booking_status_from_state = Booking.booking_statuses[aasm.from_state]
    booking_status_time_stamp.booking_status_to_state = Booking.booking_statuses[aasm.to_state]
    booking_status_time_stamp.created_at = DateTime.now
    booking_status_time_stamp.save
  end

end
