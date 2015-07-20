class CreateInventories < ActiveRecord::Migration
  def up
    create_table :inventories do |t|
      t.references :car_group
      t.references :location
      t.timestamps :start_time
      t.timestamps :end_time
      t.integer :number_of_cars
      t.timestamps null: false
    end
    add_index :inventories, [:car_group_id, :location_id]
  end

  def down
    drop_table :inventories
  end

end
