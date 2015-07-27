class CreateBookingSchedules < ActiveRecord::Migration
  def up
    create_table :booking_schedules do |t|
      t.references :booking
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps null: false
    end
  end

  def down
    drop_table :booking_schedules
  end

end
