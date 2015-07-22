class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :car
  belongs_to :car_group
  belongs_to :location
  has_many :booking_status_time_stamps

  include AASM

  enum booking_status: {
    initiated: 1,
    paid: 2,
    allocated: 3,
    checkout: 4,
    completed: 5,
    cancelled: 6
  }

  aasm :column => :booking_status, :skip_validation_on_save => true, :enum => true do
      state :initiated, initial: true
      state :awaiting_payment
      state :paid
      state :allocated
      state :checkout
      state :completed
      state :cancelled

      event :start_payment do
        transitions :from => :initiated , :to => :awaiting_payment
        after do
          puts "Set state to awaiting"
          puts "Start payment process"
          puts "decrease inventory"
        end
      end

      event :successful_payment do
        transitions :from => :awaiting_payment , :to => :paid
      end

      event :car_allocation do
        transitions :from => :paid, :to => :allocated
      end

      event :checkout do
        transitions :from => :allocated, :to => :checkout
      end

      event :completed do
        transitions :from => :checkout, :to => :completed
      end

      event :cancellation_from_initiated do
        transitions :from => :initiated, :to => :cancelled
      end

      event :cancellation_from_paid do
        transitions :from => :paid, :to => :cancelled
      end

      event :cancellation_from_allocated do
        transitions :from => :allocated, :to => :cancelled
      end

      event :cancellation_from_checkout do
        transitions :from => :checkout, :to => :cancelled
      end

  end


  def payment_successful?
    true
  end

end
