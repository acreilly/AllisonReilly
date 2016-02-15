class WeddingGuest < ActiveRecord::Base
  belongs_to :wedding_party
  validate :firstname, :lastname, :ceremony, :reception, presence: true

  validate :guest_presence
  # close rsvp 3 weeks before wedding date

  def full_name
    "#{firstname} #{lastname}".strip
  end

  def guest_presence
    if WeddingGuest.where("firstname = '#{firstname}' AND lastname = '#{lastname}'").any?
      errors.add(:firstname, "It looks like #{full_name} already RSVP'd!")
    end
  end
end
