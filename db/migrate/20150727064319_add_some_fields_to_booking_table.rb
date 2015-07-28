class AddSomeFieldsToBookingTable < ActiveRecord::Migration
  def up
    add_column :bookings, :actual_start_time, :datetime
    add_column :bookings, :actual_end_time, :datetime
    add_column :bookings, :start_km, :integer
    add_column :bookings, :end_km, :integer
    add_column :bookings, :excess_km, :integer
    add_column :bookings, :excess_fuel, :integer
    add_column :bookings, :promo, :string
    add_column :bookings, :offer_id, :integer
    add_column :bookings, :price_id, :integer
    add_column :bookings, :pricing_version_id, :integer
  end

  def down
    remove_column :bookings, :pricing_version_id
    remove_column :bookings, :price_id
    remove_column :bookings, :offer_id
    remove_column :bookings, :promo
    remove_column :bookings, :excess_fuel
    remove_column :bookings, :excess_km
    remove_column :bookings, :end_km
    remove_column :bookings, :start_km
    remove_column :bookings, :actual_end_time
    remove_column :bookings, :actual_start_time
  end

end
