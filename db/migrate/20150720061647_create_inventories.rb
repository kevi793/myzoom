class CreateInventories < ActiveRecord::Migration
  def up
    create_table :inventories do |t|
      t.references :car_group
      t.references :location
      t.datetime :start_time
      t.datetime :end_time
      t.integer :number_of_cars
      t.timestamps null: false
    end
    add_index :inventories, [:start_time, :end_time]
  end

  def down
    drop_table :inventories
  end

end
