class Car < ActiveRecord::Base
  belongs_to :car_group
  belongs_to :location
  as_enum :status, live: 0, banned: 1
end
