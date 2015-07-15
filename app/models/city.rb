class City < ActiveRecord::Base
  has_many :locations, dependent: :destroy

  validates :name, length: {in: 2..25}, format: {with: /\A[a-zA-Z]+\z/,
    message: "only allows letters"}, presence: true,

end
