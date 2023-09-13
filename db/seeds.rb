# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Item.destroy_all
User.destroy_all

user1 = User.create!({ username: "test", email: 'test@test.com', password: 'password', location: 'testville', swapzi_score: 500000 })
user2 = User.create!({ username: "Josh", email: 'josh@test.com', password: 'password', location: 'London', swapzi_score: 100 })
user3 = User.create!({ username: "Bay", email: 'bay@test.com', password: 'password', location: 'Berlin', swapzi_score: 500 })
user4 = User.create!({ username: "Ben", email: 'ben@test.com', password: 'password', location: 'Taunton', swapzi_score: 200 })
user5 = User.create!({ username: "James", email: 'james@test.com', password: 'password', location: 'Kent', swapzi_score: 1000 })

categories = ["books", "electronics", "musical instruments", "furniture", "clothes", "household appliances", "sports gear", "decorations"]

100.times do
  item = Item.new({ name: "#{Faker::Adjective.negative.capitalize} #{Faker::Appliance.equipment}", description: Faker::Movies::HarryPotter.quote, category: categories.sample, swapzi_points: (100..500).to_a.sample })
  item.user = [user1, user2, user3, user4, user5].sample
  item.save!
end
