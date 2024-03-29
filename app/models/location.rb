class Location < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :address

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
