class AddCarGroupIdToCarBlocksTable < ActiveRecord::Migration
  def up
    add_column :carblocks, :car_group_id, :integer
  end

  def down
    remove_column :carblocks, :car_group_id
  end
end
