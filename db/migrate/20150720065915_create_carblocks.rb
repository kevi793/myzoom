class CreateCarblocks < ActiveRecord::Migration
  def up
    create_table :carblocks do |t|
      t.references :car
      t.references :car_group
      t.references :location
      t.timestamps :start_time
      t.timestamps :end_time
      t.timestamps null: false
    end
    add_index :carblocks, [:car_id, :car_group_id, :location_id]
  end

  def down
    drop_table :carblocks
  end

end
