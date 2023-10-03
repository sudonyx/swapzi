# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Item.destroy_all
User.destroy_all
Achievement.destroy_all

user0 = User.new({ username: "Swapzi Admin", email: 'admin@swapzi.site', password: 'swapziadmin', location: 'Swapzi HQ', swapzi_score: 999999 })
user0.photo.attach(io: File.open("app/assets/images/logo-draft.png"), filename: "user0.png", content_type: "image/png")
user0.save!

user1 = User.new({ username: "Test", email: 'test@test.com', password: 'password', location: 'Paris', swapzi_score: 500000 })
user1.photo.attach(io: File.open("app/assets/images/user_icons/alpaca-cowboy-hat.jpg"), filename: "user1.jpg", content_type: "image/jgp")
user1.save!

user2 = User.new({ username: "Josh", email: 'josh@test.com', password: 'password', location: 'London', swapzi_score: 100 })
user2.photo.attach(io: File.open("app/assets/images/user_icons/alpaca-hard-hat.jpg"), filename: "user2.jpg", content_type: "image/jgp")
user2.save!

user3 = User.new({ username: "Bay", email: 'bay@test.com', password: 'password', location: 'Berlin', swapzi_score: 500 })
user3.photo.attach(io: File.open("app/assets/images/user_icons/alpaca-graduation-cap.jpg"), filename: "user3.jpg", content_type: "image/jgp")
user3.save!

user4 = User.new({ username: "Ben", email: 'ben@test.com', password: 'password', location: 'Taunton', swapzi_score: 200 })
user4.photo.attach(io: File.open("app/assets/images/user_icons/alpaca-wizard-hat.jpg"), filename: "user4.jpg", content_type: "image/jgp")
user4.save!

user5 = User.new({ username: "James", email: 'james@test.com', password: 'password', location: 'Kent', swapzi_score: 1000 })
user5.photo.attach(io: File.open("app/assets/images/user_icons/alpaca-trilby.jpg"), filename: "user5.jpg", content_type: "image/jgp")
user5.save!


achievement1 = Achievement.new(name: "Swap Lover", description: "Favourite 5 items!")
achievement1.photo.attach(io: File.open("app/assets/images/achievement_icons/resh(1).png"), filename: "achievement1.png", content_type: "image/png")
achievement1.save

achievement2 = Achievement.new(name: "Swap Obsessed", description: "Favourite 20 items!")
achievement2.photo.attach(io: File.open("app/assets/images/achievement_icons/resh(2).png"), filename: "achievement2.png", content_type: "image/png")
achievement2.save

achievement3 = Achievement.new(name: "Fav Spammer", description: "Favourite 50 items!")
achievement3.photo.attach(io: File.open("app/assets/images/achievement_icons/resh(3).png"), filename: "achievement3.png", content_type: "image/png")
achievement3.save

achievement4 = Achievement.new(name: "Swap Rookie", description: "Complete your 1st swap!")
achievement4.photo.attach(io: File.open("app/assets/images/achievement_icons/resh(4).png"), filename: "achievement4.png", content_type: "image/png")
achievement4.save

achievement5 = Achievement.new(name: "Seasoned Swapper", description: "Complete your 5th swap!")
achievement5.photo.attach(io: File.open("app/assets/images/achievement_icons/resh(5).png"), filename: "achievement5.png", content_type: "image/png")
achievement5.save

achievement6 = Achievement.new(name: "Swap Master", description: "Complete your 20th swap!")
achievement6.photo.attach(io: File.open("app/assets/images/achievement_icons/resh(6).png"), filename: "achievement6.png", content_type: "image/png")
achievement6.save

achievement7 = Achievement.new(name: "Swap Til' You Drop", description: "Swap an item that has been swapped 10 times or more!")
achievement7.photo.attach(io: File.open("app/assets/images/achievement_icons/resh(7).png"), filename: "achievement7.png", content_type: "image/png")
achievement7.save

achievement8 = Achievement.new(name: "Non-Stop Swap", description: "Relist an item that you received in a swap!")
achievement8.photo.attach(io: File.open("app/assets/images/achievement_icons/resh(8).png"), filename: "achievement8.png", content_type: "image/png")
achievement8.save

achievement9 = Achievement.new(name: "Welcome To The Club", description: "Post an item!")
achievement9.photo.attach(io: File.open("app/assets/images/achievement_icons/resh(9).png"), filename: "achievement9.png", content_type: "image/png")
achievement9.save

achievement10 = Achievement.new(name: "Night Owl", description: "Complete a swap in the middle of the night!")
achievement10.photo.attach(io: File.open("app/assets/images/achievement_icons/resh(10).png"), filename: "achievement10.png", content_type: "image/png")
achievement10.save

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
  when "Other"
    item.photo.attach(io: File.open("app/assets/images/seed_images/#{%w[book gameboy guitar desk jacket toaster bicycle plant].sample}.jpg"), filename: "other.jpg", content_type: "image/jpg")
  end
  item.save!
end
