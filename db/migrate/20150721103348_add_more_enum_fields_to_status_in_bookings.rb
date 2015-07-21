class AddMoreEnumFieldsToStatusInBookings < ActiveRecord::Migration
  def up
    remove_column(:bookings,:booking_status)
    add_column(:bookings,:booking_status, "ENUM('initiate', 'paid', 'allocated', 'checkout', 'completed', 'cancelled')")
  end

  def down
    remove_column(:bookings, :booking_status)
    add_column(:bookings, :booking_status, "ENUM('live', 'completed', 'cancelled')")
  end

end
