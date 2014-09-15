design_files = []
photo_files = []
dev_files = []
files = Dir.entries("public/img")


files.each do |filename|
  if /design/.match(filename) != nil
    design_files << filename
  elsif /img/.match(filename) != nil
    photo_files << filename
  elsif /dev/.match(filename) != nil
    dev_files << filename
  end
end


photo_files.each do |photo|
  Image.create(filename: photo, category: "photography", technologies: "Pentax K100D")
end

design_files.each do |design|
  Image.create(filename: design, category: "design")
end

dev_files.each do |dev|
  Image.create(filename: dev, category: "dev")
end
