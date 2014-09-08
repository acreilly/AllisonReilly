class Image < ActiveRecord::Base
  validates :filename, presence: true
end