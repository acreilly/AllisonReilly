class WeddingParty < ActiveRecord::Base
  has_many :guests, class_name: 'WeddingGuest'
  validate :email, presence: true
end
