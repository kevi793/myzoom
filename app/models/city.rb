class City < ActiveRecord::Base
  validates :name, length: {in: 2..25}, format: {with: /\A[a-zA-Z]+\z/,
    message: "only allows letters"}, presence: true
end
