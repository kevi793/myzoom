class CreatePrices < ActiveRecord::Migration
  def up
    create_table :prices do |t|
      t.references :car_group
      t.references :city
      t.datetime :start_time
      t.datetime :created_at
    end
  end

  def down
    drop_table :prices
  end

end
