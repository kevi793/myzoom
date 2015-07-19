class CreateCarGroups < ActiveRecord::Migration
  def up
    create_table :car_groups do |t|
      t.string :name
      t.integer :seats
      t.integer :tariff
      t.integer :minimum_billing
      t.string :image_url
      t.integer :excess_km_charges
      t.timestamps null: false
    end
  end

  def down
    drop_table :car_groups
  end

end
