# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Item.destroy_all
User.destroy_all

user1 = User.create!({ username: "Test", email: 'test@test.com', password: 'password', location: 'Testville', swapzi_score: 500000 })
user2 = User.create!({ username: "Josh", email: 'josh@test.com', password: 'password', location: 'London', swapzi_score: 100 })
user3 = User.create!({ username: "Bay", email: 'bay@test.com', password: 'password', location: 'Berlin', swapzi_score: 500 })
user4 = User.create!({ username: "Ben", email: 'ben@test.com', password: 'password', location: 'Taunton', swapzi_score: 200 })
user5 = User.create!({ username: "James", email: 'james@test.com', password: 'password', location: 'Kent', swapzi_score: 1000 })

100.times do
  name = Faker::Commerce.product_name
  description = []
  (3..8).to_a.sample.times do 
    description << Faker::Company.catch_phrase 
  end
  description = description.join(". ")
  category = ["Books", "Electronics", "Musical Instruments", "Furniture", "Clothes", "Household Appliances", "Sports Gear", "Decorations", "Other"].sample
  swapzi_points = (100..500).to_a.sample

  item = Item.new({ name: name, description: description, category: category, swapzi_points: swapzi_points })
  item.user = [user1, user2, user3, user4, user5].sample
  case category
  when "Books"
    item.photo.attach(io: File.open("app/assets/images/seed_images/book.jpg"), filename: "book.jpg", content_type: "image/jpg")
  when "Electronics"
    item.photo.attach(io: File.open("app/assets/images/seed_images/gameboy.jpg"), filename: "gameboy.jpg", content_type: "image/jpg")
  when "Musical Instruments"
    item.photo.attach(io: File.open("app/assets/images/seed_images/guitar.jpg"), filename: "guitar.jpg", content_type: "image/jpg")
  when "Furniture"
    item.photo.attach(io: File.open("app/assets/images/seed_images/desk.jpg"), filename: "desk.jpg", content_type: "image/jpg")
  when "Clothes"
    item.photo.attach(io: File.open("app/assets/images/seed_images/jacket.jpg"), filename: "jacket.jpg", content_type: "image/jpg")
  when "Household Appliances"
    item.photo.attach(io: File.open("app/assets/images/seed_images/toaster.jpg"), filename: "toaster.jpg", content_type: "image/jpg")
  when "Sports Gear"
    item.photo.attach(io: File.open("app/assets/images/seed_images/bicycle.jpg"), filename: "bicycle.jpg", content_type: "image/jpg")
  when "Decorations"
    item.photo.attach(io: File.open("app/assets/images/seed_images/plant.jpg"), filename: "plant.jpg", content_type: "image/jpg")
  end
  item.save!
end
