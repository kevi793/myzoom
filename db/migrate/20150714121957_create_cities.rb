class CreateCities < ActiveRecord::Migration
  def up
    create_table :cities do |t|
      t.string :name, :null => false, :limit => 25
    end
    add_index :cities, :name
  end

  def down
    remove_index :cities, :name
    drop_table :cities
  end

end
