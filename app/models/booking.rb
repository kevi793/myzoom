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
        transitions :from => :initiated , :to => :awaiting_payment
        after do
          set_booking_status_changes
          block_inventory
        end
      end

      event :successful_payment do
        transitions :from => :awaiting_payment , :to => :paid, :after => :set_booking_status_changes, :guard => :payment_successful?
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

      event :cancellation do
        after do
          set_booking_status_changes
          if Booking.booking_statuses[aasm.from_state] != 1
            release_inventory
          end
        end
        transitions :from => :initiated, :to => :cancelled
        transitions :from => :awaiting_payment, :to => :cancelled
        transitions :from => :paid, :to => :cancelled
        transitions :from => :allocated, :to => :cancelled
        transitions :from => :checkout, :to => :cancelled
      end

  end


  def payment_successful?
    payment_status = "" #some api call
    if payment_status == true
      true
    else
      self.cancellation
      false
    end
  end

  def set_booking_status_changes
    self.bookings << BookingStatusTimeStamp.create(
    booking_id: self.id,
    booking_status_from_state: status_id_for(aasm.from_state),
    booking_status_to_state: status_id_for(aasm.to_state),
    created_at: DateTime.now)
  end

  def status_id_for state
    Booking.booking_statuses[state]
  end

  def block_inventory
    Inventory.block_inventory(self)
  end

  def release_inventory
    Inventory.release_inventory(self)
  end


end
