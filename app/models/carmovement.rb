class Carmovement < ActiveRecord::Base
  belongs_to :location
  belongs_to :car
end
