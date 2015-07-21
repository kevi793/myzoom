class Carblock < ActiveRecord::Base
  belongs_to :car
  belongs_to :locations
end
