class Carblock < ActiveRecord::Base
  belongs_to :car
  belongs_to :car_group
  belongs_to :locations
end
