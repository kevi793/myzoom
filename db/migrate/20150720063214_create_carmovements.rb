class CreateCarmovements < ActiveRecord::Migration
  def up
    create_table :carmovements do |t|
      t.references :car
      t.references :location
      t.references :car_group
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps null: false
    end
    add_index :carmovements, [:car_id, :location_id, :car_group_id]
  end

  def down
    drop_table :carmovements
  end

end
