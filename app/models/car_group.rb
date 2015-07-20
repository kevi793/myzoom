class CarGroup < ActiveRecord::Base
  has-many :cars, dependent: :destroy
  has_many :carblocks
  has_many :carmovements
  has_many :inventories
end
