class AddCarGroupIdToCarMovementsTable < ActiveRecord::Migration
  def up
    add_column :carmovements, :car_group_id, :integer
  end
  def down
    remove_column :carmovements, :car_group_id
  end
end
