class Location < ActiveRecord::Base
  belongs_to :city
  has_many :cars
  has_many :carmovements
  has_many :carblocks
  has_many :inventories
  has_many :bookings
  
  validates :name,
            :length => {in: 2..25, :message => 'Must be between 2 to 25 characters'},
            :format => {with: /\A[a-zA-Z]+\z/, message: "only allows letters"},
            :presence => {:message => " cannot be blank"}

  validates :address,
            :length => {in: 2..100, :message => 'Must be between 2 to 100 characters'},
            :presence => {:message => " cannot be blank"}

  validates :latitude,
            :presence => {:message => ' cannot be blank'},
            :numericality => {:message => ' can be only float', only_float: true}

  validates :longitude,
            :presence => {:message => ' cannot be blank'},
            :numericality => {:message => ' can be only float', only_float: true}

  validates :map_link,
            :url => {:message => ' is not correct'},
            :presence => {:message => ' cannot be blank'},
            :uniqueness => {:message => ' already exists'}

  validates :description,
            :length => {in: 2..100, :message => ' should  be between 2-100 characters'},
            :presence => {:message => ' cannot be blank'}

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
