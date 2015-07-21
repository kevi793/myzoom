class Search < ActiveRecord::Base
    has_no_table
    def self.search(start_time, end_time)
      cg = CarGroup.joins(:cars, :carmovements).where('carmovements.start_time <= ? AND carmovements.end_time >= ?', start_time, end_time)
      cg = cg.to_json
    end
end
