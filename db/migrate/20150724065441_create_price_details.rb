class CreatePriceDetails < ActiveRecord::Migration
  def up
    create_table :price_details do |t|
      t.references :price
      t.integer :fare_per_hour
      t.integer :fare_per_day
      t.integer :fare_per_week
      t.integer :extra_fare_per_day
      t.integer :extra_fare_per_week
      t.integer :extra_fare_per_hour
    end
  end

  def down
    drop_table :price_details
  end

end
