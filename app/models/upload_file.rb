class UploadFile < ActiveRecord::Base
    require 'csv'
    def self.import(file)
      debugger
      CSV.foreach(file.path, {:headers => true, :converters => :numeric}) do |row|
          puts row
      end
    end



end
