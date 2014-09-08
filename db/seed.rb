counter = 0
48.times do
  Image.create(filename: "img" << counter.to_s, category: "photography")
  counter += 1
end