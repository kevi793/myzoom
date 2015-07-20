class City < ActiveRecord::Base
  has_many :locations, dependent: :destroy
  validates :name,
            :length => {in: 2..25, :message => 'Must be between 2 to 25 characters'},
            :format => {with: /\A[a-zA-Z]+\z/, message: "only allows letters"},
            :presence => {:message => 'name cannot be blak'},
            :uniqueness => {:message => 'city already exists'}

end
