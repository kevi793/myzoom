class CreatePricingVersions < ActiveRecord::Migration
  def up
    create_table :pricing_versions do |t|
      t.string :version
      t.string :details
      t.string :start_time
      t.timestamps null: false
    end
  end

  def down
    drop_table :pricing_versions
  end

end
