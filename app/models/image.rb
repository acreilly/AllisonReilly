require 'csv'
class Image < ActiveRecord::Base
  validates :filename, presence: true


  def self.export
    column_names = Image.column_names
    column_names.shift
    CSV.generate({}) do |csv|
      csv << column_names
      Image.all.each do |image|
        csv << [
          image.title,
          image.filename,
          image.location,
          image.dates,
          image.technologies,
          image.category,
          image.link,
          image.description
        ]
      end
    end
  end
end
