class Inventory < ActiveRecord::Base
  belongs_to :car_group
  belongs_to :location

  def self.createInventory
    carmovements = Carmovement.all
     carmovements.each do |e|
      start_time = e.start_time
      end_time = e.end_time
      car = Car.find(e.car_id)
      car_group_id = car.car_group_id
      while start_time < end_time
        inventory = Inventory.where(["location_id = ? and car_group_id = ? and start_time = ? and end_time = ?",
          e.location_id, car_group_id, start_time, start_time + 15.minutes])
        if inventory.blank?
          Inventory.create(:car_group_id => car_group_id, :start_time => start_time, :end_time => start_time+15.minutes,
          :location_id => e.location_id, :number_of_cars => 1)
        else
          inventory[0].increment!(:number_of_cars)
        end
        start_time += 15.minutes
      end
    end
  end


end
