require 'smarter_csv'
file = SmarterCSV.process('public/files/images.csv')

file.each do |image|
  unless image[:technologies].nil?
    image[:technologies] = image[:technologies].split('/').join(', ')
  end
  Image.create(image)
end
