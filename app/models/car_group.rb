class CarGroup < ActiveRecord::Base
  has-many :cars, dependent: :destroy
end
