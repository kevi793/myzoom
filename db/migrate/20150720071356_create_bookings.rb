class CreateBookings < ActiveRecord::Migration
  def up
    create_table :bookings do |t|
      t.references :user
      t.references :car
      t.references :car_group
      t.references :location
      t.datetime :start_time
      t.datetime :end_time
      t.integer :booking_status
      t.timestamps null: false
    end
    add_index :bookings, [:user_id, :car_group_id, :location_id]
  end

  def down
    drop_table :bookings
  end

end
