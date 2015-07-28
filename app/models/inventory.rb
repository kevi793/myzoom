class Inventory < ActiveRecord::Base
  belongs_to :car_group
  belongs_to :location

  def self.createInventory
    carmovements = Carmovement.get_current_or_future_movements(DateTime.now)
     carmovements.each do |e|
      start_time = [e.start_time, Time.now].max
      end_time = e.end_time
      start_time = start_time - start_time.sec
      start_time = start_time - start_time.min*60
      end_time = end_time - end_time.sec
      end_time = end_time - end_time.min*60
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

  def self.checkCarAvailability(start_time, end_time)
    inventories = Inventory.where("start_time >= ? and end_time <= ?",start_time, end_time)
    inventories = inventories.group(:location_id, :car_group_id).minimum(:number_of_cars)
    inventories.each do |inventory|
      if inventory[1] > 0
        puts "Location at #{inventory[0][0]} , car_group #{inventory[0][1]} has cars #{inventory[1]}"
      end
    end
  end

  def self.block_inventory(start_time, end_time, car_group_id, location_id)
    inventories = inventories_of_cargroup_at_location_between_start_end_time(start_time, end_time, car_group_id, location_id)
    inventories.each do |inventory|
      inventory.decrement!(:number_of_cars)
    end
  end

  def self.release_inventory(start_time, end_time, car_group_id, location_id)
    inventories = inventories_of_cargroup_at_location_between_start_end_time(start_time, end_time, car_group_id, location_id)
    inventories.each do |inventory|
      inventory.increment!(:number_of_cars)
    end
  end

  def self.inventories_of_cargroup_at_location_between_start_end_time(start_time, end_time, car_group_id, location_id)
    inventories = Inventory.where("start_time >= ? and end_time <= ? and car_group_id = ? and location_id = ?",
    start_time, end_time, car_group_id, location_id)
  end

end
