class CreateCars < ActiveRecord::Migration
  def up
    create_table :cars do |t|
      t.references :car_group, :index => true
      t.references :location  
      t.integer :car_status
      t.string :color
      t.string :image_url
      t.timestamps null: false
    end
  end

  def down

  end

end
