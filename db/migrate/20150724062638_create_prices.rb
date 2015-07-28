class CreatePrices < ActiveRecord::Migration
  def up
    create_table :prices do |t|
      t.references :car_group
      t.references :city
      t.datetime :start_time
      t.datetime :created_at
      t.integer :fare_per_hour
      t.integer :fare_per_day
      t.integer :fare_per_week
      t.integer :extra_fare_per_hour
      t.integer :extra_fare_per_day
      t.integer :extra_fare_per_week
    end
  end

  def down
    drop_table :prices
  end

end
