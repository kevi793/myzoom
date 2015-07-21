class Inventory < ActiveRecord::Base
  belongs_to :car_group
  belongs_to :location
end
