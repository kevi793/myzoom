class Price < ActiveRecord::Base
  has_many :price_details, dependent: :destroy
end
