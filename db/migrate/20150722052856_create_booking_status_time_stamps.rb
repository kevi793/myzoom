class CreateBookingStatusTimeStamps < ActiveRecord::Migration
  def up
    create_table :booking_status_time_stamps do |t|
      t.references :booking, :index => true
      t.integer :booking_status
      t.datetime :created_at, null: false
    end
  end

  def down
    drop_table :booking_status_time_stamps
  end


end
