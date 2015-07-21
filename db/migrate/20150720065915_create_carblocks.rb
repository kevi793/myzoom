class CreateCarblocks < ActiveRecord::Migration
  def up
    create_table :carblocks do |t|
      t.references :car
      t.references :location
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps null: false
    end
    add_index :carblocks, [:car_id, :location_id]
  end

  def down
    drop_table :carblocks
  end

end
