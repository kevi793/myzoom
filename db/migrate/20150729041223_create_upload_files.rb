class CreateUploadFiles < ActiveRecord::Migration
  def up
    create_table :upload_files do |t|
      t.integer :cargroup_id
      t.integer :hourly_fare
      t.integer :hourly_discounted_fare
      t.integer :hourly_bod_fare
      t.integer :daily_discounted_fare
      t.integer :excess_km
    end
  end

  def down
    drop_table :upload_files
  end

end
