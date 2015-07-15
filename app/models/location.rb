class Location < ActiveRecord::Base
  belongs_to :city

  validates :name,
            :length => {in: 2..25, :message => 'Must be between 2 to 25 characters'},
            :format => {with: /\A[a-zA-Z]+\z/, message: "only allows letters"},
            :presence => {:message => 'location cannot be blak'}

  validates :address,
            :length => {in: 2..100, :message => 'Must be between 2 to 100 characters'},
            :presence => {:message => 'address cannot be blak'}

  validates :latitude
            :presence => {:message => 'latitiude cannot be blank'}
            :numericality => {only_float: true, :message => 'latitude should be float'}

  validates :longitude
            :presence => {:message => 'longitude cannot be blank'}
            :numericality => {only_float: true, :message => 'longitude should be float'}

  validates :map_link,
            :url => {:message => 'url is not correct'},
            :presence => {:message => 'map link cannot be blank'}
            
  validates :description,
            :length => {in: 2..100, :message => 'description should be between 2-100 characters'},
            :presence => {:message => 'description cannot be blank'}

  validates :location, uniqueness: {scope: [:latitude, :longitude]}

end
