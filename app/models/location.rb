class Location < ActiveRecord::Base
  belongs_to :city
  validates :name, length: {in: 2..25}, format: {with: /\A[a-zA-Z]+\z/,
    message: "only allows letters"}, presence: true
  validates :address, length {in: 2..100}, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates_numericality_of :latitude, :longitude
  validates :map_link, url: true, presence: true
  validates :description, length: {2..100}, presence: true
  validates :location, uniqueness: {scope: [:latitude, :longitude]}
end
