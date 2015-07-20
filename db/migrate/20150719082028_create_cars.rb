class CreateCars < ActiveRecord::Migration
  def up
    create_table :cars do |t|
      t.references :car_group, :index => true
      t.references :location
      t.column :car_status, "ENUM('live', 'banned')"
      t.string :color
      t.string :image_url
      t.timestamps null: false
    end
  end

  def down
    drop_table :cars
  end

end
