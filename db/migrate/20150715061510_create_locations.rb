class CreateLocations < ActiveRecord::Migration
  def up
    create_table :locations do |t|
      t.references :city, index: true
      t.string :name, :null => false, :limit => 25
      t.string :address, :null => false, :limit => 100
      t.float :latitude, :null => false
      t.float :longitude, :null => false
      t.string :map_link, :null => false
      t.string :description, :null => false, :limit => 100
    end
    add_index :locations, [:city_id]
  end

  def down
    remove_index :;locations, [:city_id]
    drop_table :locations
  end
end
