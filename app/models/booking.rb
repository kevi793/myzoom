class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :car
  belongs_to :car_group
  belongs_to :location
  has_many :booking_status_time_stamps
  has_many :booking_schedules
  belongs_to :pricing_version

  after_create :constructor
  after_initialize :initialise


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

  aasm :column => :booking_status, :skip_validation_on_save => true, :enum => true do

      state :initiated, initial: true
      state :awaiting_payment, :before_enter => :set_booking_configs
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
          BookingWorker.perform_at(CONFIG["booking"]["PAYMENT_WAIT_TIME"].minutes,
          self.id, "call_successful_payment")
        end
      end

      event :successful_payment do
        transitions :from => :awaiting_payment , :to => :paid, :guard => :payment_successful?
        after do
          set_booking_status_changes
          time_after_to_book_car = [0,
          self.start_time - DateTime.now - CONFIG["booking"]["MINUTES_BEFORE_START_TIME_TO_BOOK_ACTUAL_CAR"].minutes].max
          BookingWorker.perform_at(time_after_to_book_car,
          self.id, "schedule_job_for_car_booking")
        end
      end

      event :car_allocation do
        transitions :from => :paid, :to => :allocated, :after => :set_booking_status_changes
      end

      event :checkout do
        transitions :from => :allocated, :to => :checkout, :after => :set_booking_status_changes, :guard => :car_allocation_successful?
      end

      event :completed do
        transitions :from => :checkout, :to => :completed, :after => :set_booking_status_changes
      end

      event :rescheduled do
        transitions :from => :initiated, :to => :initiated
        transitions :from => :awaiting_payment, :to => :initiated
        transitions :from => :paid, :to => :initiated
        transitions :from => :allocated, :to => :initiated

        after do
          set_booking_status_changes
          if Booking.booking_statuses[aasm.from_state] != 1
            release_inventory
          end
          remove_scheduled_sidekiq_processes
          #some pricing call
        end
      end

      event :cancellation do
        transitions :from => :initiated, :to => :cancelled
        transitions :from => :awaiting_payment, :to => :cancelled
        transitions :from => :paid, :to => :cancelled
        transitions :from => :allocated, :to => :cancelled
        transitions :from => :checkout, :to => :cancelled
        transitions :from => :rescheduled, :to => :cancelled
        after do
          set_booking_status_changes
          if Booking.booking_statuses[aasm.from_state] != 1
            release_inventory
          end
          #some refunds
        end
      end

  end


  def payment_successful?
    payment_status = true #some api call
    if payment_status == true
      true
    else
      self.cancellation!
      false
    end
  end


  def car_allocation_successful?
    if self.car_id != nil
      true
    else
      self.cancellation!
      false
    end
  end

  def set_booking_status_changes
    self.booking_status_time_stamps << BookingStatusTimeStamp.create(
    booking_id: self.id,
    booking_status_from_state: status_id_for(aasm.from_state),
    booking_status_to_state: status_id_for(aasm.to_state),
    created_at: DateTime.now)
  end

  def status_id_for state
    Booking.booking_statuses[state]
  end

  def block_inventory
    Inventory.block_inventory(self.start_time, self.end_time, self.car_group_id, self.location_id)
  end

  def release_inventory
    Inventory.release_inventory(self.start_time, self.end_time, self.car_group_id, self.location_id)
  end

  scope :cars_in_use, lambda { |car_group_id, location_id, current_time|
    where("car_group_id = ? and location_id = ? and start_time <= ? and end_time >= ? and booking_status != ?",
    car_group_id, location_id, current_time, current_time, Booking.booking_statuses[:cancelled])
  }

  def set_booking_configs
    debugger
    # if car was allocated, then unallocate the car
    self.car_id = nil if !self.car_id != nil
    
  end


  def initialise

    #set pricing version object
    #@@pricing_version = self.pricing_version.constantize.new
    #set booking_schedules
    #set start time end time to new start end time
    #call reschedule charges
    #remove old sidekiq if present
    #cancel car if booked

  end

  def constructor

    #get pricing version id
    #get price detail id

  end


  def remove_scheduled_sidekiq_processes
    r = Sidekiq::ScheduledSet.new
    jobs = r.select {|schedule_job| schedule_job.args[0] == self.id}
    jobs.each(&:delete)
  end

end
