class Carmovement < ActiveRecord::Base
  belongs_to :car_group
  belongs_to :location
  belongs_to :car  
end
