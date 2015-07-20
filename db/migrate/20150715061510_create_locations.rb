class CreateLocations < ActiveRecord::Migration
  def up
    create_table :locations do |t|
      t.references :city
      t.string :name, :limit => 25
      t.string :address, :limit => 100
      t.float :latitude
      t.float :longitude
      t.string :map_link
      t.string :description, :limit => 100
    end
    add_index :locations, [:city_id, :name]
  end

  def down
    remove_index :locations, [:city_id, :name]
    drop_table :locations
  end
end
