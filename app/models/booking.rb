class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :car
  belongs_to :car_group
  belongs_to :location

  include AASM

  enum booking_status: {
    initiated: 4,
    paid: 2
  }
  aasm :column => :booking_status, :enum => true do
      state :initiated, initial: true
      state :paid
      event :make_payment do
        transitions :from => :initiated , :to => :paid
      end
  end

  
end
