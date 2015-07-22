class CreateBookingStatusTimeStamps < ActiveRecord::Migration
  def up
    create_table :booking_status_time_stamps do |t|
      t.references :booking, :index => true
      t.integer :booking_status_from_state
      t.integer :booking_status_to_state
      t.references :user
      t.datetime :created_at
    end
  end

  def down
    drop_table :booking_status_time_stamps
  end


end
