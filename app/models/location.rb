class Location < ActiveRecord::Base
  belongs_to :city

  validates :name,
            :length => {in: 2..25, :message => 'Must be between 2 to 25 characters'},
            :format => {with: /\A[a-zA-Z]+\z/, message: "only allows letters"},
            :presence => {:message => "name cannot be blank"}

  validates :address,
            :length => {in: 2..100, :message => 'Must be between 2 to 100 characters'},
            :presence => {:message => "address cannot be blank"}

  validates :latitude,
            :presence => {:message => 'latitiude cannot be blank'},
            :numericality => {:message => 'latitude can be only float', only_float: true}

  validates :longitude,
            :presence => {:message => 'longitude cannot be blank'},
            :numericality => {:message => 'longitude can be only float', only_float: true}

  validates :map_link,
            :url => {:message => 'url is not correct'},
            :presence => {:message => 'map link cannot be blank'},
            :uniqueness => {:message => 'map_link already exists'}

  validates :description,
            :length => {in: 2..100, :message => 'description should  be between 2-100 characters'},
            :presence => {:message => 'description cannot be blank'}

  after_save :validate_model

  def validate_model
    epsilon = 0.00001
    locations = Location.where(["(latitude >= ? and latitude <= ?) and (longitude >= ? and longitude <= ?)",self.latitude-epsilon,self.latitude+epsilon,self.longitude-epsilon,self.longitude+epsilon])
    if locations.count > 1
      self.destroy
      errors[:base] << 'Location with same latitude and longitude already exists'
    end
  end

end
