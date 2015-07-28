class PricingVersion < ActiveRecord::Base
    has_many :bookings
end
