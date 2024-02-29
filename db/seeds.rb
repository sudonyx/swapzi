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

user1 = User.new({ username: "Lucy", email: 'test@test.com', password: 'password', location: 'Paris', swapzi_score: 500000 })
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

def generate_description
  description = []
  (3..8).to_a.sample.times do
    description << Faker::Company.catch_phrase
  end
  description = description.join('. ')
end

item = Item.new({ name: "Mini Fridge", category: "Household Appliances", user: user1, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/MiniFridge.jpg"), filename: "appliances.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Slow Cooker", category: "Household Appliances", user: user2, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/SlowCooker.jpg"), filename: "appliances.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Coffee Maker", category: "Household Appliances", user: user3, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/CoffeeMaker.jpg"), filename: "appliances.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Rice Cooker", category: "Household Appliances", user: user4, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/RiceCooker.jpg"), filename: "appliances.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Juicer", category: "Household Appliances", user: user5, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/Juicer.jpg"), filename: "appliances.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Electric Kettle", category: "Household Appliances", user: user1, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/ElectricKettle.jpg"), filename: "appliances.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "1984 book", category: "Books", user: user2, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/1984.jpg"), filename: "books.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Brave New World book", category: "Books", user: user3, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/BraveNewWorld.jpg"), filename: "books.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "The Lord of the Rings trilogy book", category: "Books", user: user4, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/LOTR.jpg"), filename: "books.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Frankenstein paperback", category: "Books", user: user5, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/FRANKENSTEIN.jpg"), filename: "books.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "The Hitch-Hiker's Guide to the Galaxy paperback book", category: "Books", user: user1, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/hhgttg.jpg"), filename: "books.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Catch-22 paperback", category: "Books", user: user2, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/Catch22.jpg"), filename: "books.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "iPhone 7", category: "Electronics", user: user3, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/iphone7.jpg"), filename: "electronics.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Chromebook", category: "Electronics", user: user4, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/chromebook.jpg"), filename: "electronics.jgp", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Samsung TV", category: "Electronics", user: user5, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/samsungTV.jpg"), filename: "electronics.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Bluetooth Speaker", category: "Electronics", user: user1, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/BluetoothSpeaker.jpg"), filename: "electronics.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Old Hi-Fi", category: "Electronics", user: user2, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/OldHifi.jpg"), filename: "electronics.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Vinyl Record Player", category: "Electronics", user: user3, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/VinylRecordPlayer.jpg"), filename: "electronics.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Acoustic Guitar", category: "Musical Instruments", user: user4, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/AcousticGuitar.jpg"), filename: "instruments.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Trumpet", category: "Musical Instruments", user: user5, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/trumpet.jpg"), filename: "instruments.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Drum Kit", category: "Musical Instruments", user: user1, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/DrumKit.jpg"), filename: "instruments.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Banjo", category: "Musical Instruments", user: user2, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/banjo.jpg"), filename: "instruments.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Tin Whistle", category: "Musical Instruments", user: user3, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/TinWhistle.jpg"), filename: "instruments.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Saxophone", category: "Musical Instruments", user: user4, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/saxophone.jpg"), filename: "instruments.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Dining Chair", category: "Furniture", user: user5, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/DiningChair.jpg"), filename: "furniture.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Small Table", category: "Furniture", user: user1, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/SmallTable.jpg"), filename: "furniture.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Leather sofa", category: "Furniture", user: user2, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/LeatherSofa.jpg"), filename: "furniture.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Bar stools x2", category: "Furniture", user: user3, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/BarStools.jpg"), filename: "furniture.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Ottoman Bed", category: "Furniture", user: user4, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/OttomanBed.jpg"), filename: "furniture.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Bean bag", category: "Furniture", user: user5, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/BeanBag.jpg"), filename: "furniture.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Black Geometric Print Trousers", category: "Clothes", user: user1, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/BlackGeometricPrintTrousers.jpg"), filename: "clothes.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Black Polka Dot Shirt", category: "Clothes", user: user2, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/BlackPolkaDotShirt.jpg"), filename: "clothes.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Black Mini Skater Skirt", category: "Clothes", user: user3, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/BlackMiniSkaterSkirt.jpg"), filename: "clothes.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Beige Large Logo Front Jumper", category: "Clothes", user: user4, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/BeigeLargeLogoFrontJumper.jpg"), filename: "clothes.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Red Peplum Petite Midi Dress", category: "Clothes", user: user5, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/RedPeplumPetiteMidiDress.jpg"), filename: "clothes.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Blue Tie Side Sweatshirt", category: "Clothes", user: user1, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/BlueTieSideSweatshirt.jpg"), filename: "clothes.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Bike Helmet", category: "Sports Gear", user: user2, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/BikeHelmet.jpg"), filename: "sports.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Football", category: "Sports Gear", user: user3, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/football.jpg"), filename: "sports.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Cricket Bat", category: "Sports Gear", user: user4, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/CricketBat.jpg"), filename: "sports.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Goalkeeper gloves Large", category: "Sports Gear", user: user5, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/GoalkeeperGloves.jpg"), filename: "sports.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Balance bike", category: "Sports Gear", user: user1, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/BalanceBike.jpg"), filename: "sports.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Bike Pump", category: "Sports Gear", user: user2, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/BikePump.jpg"), filename: "sports.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Candle holder", category: "Decorations", user: user3, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/CandleHolder.jpg"), filename: "decorations.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Vase", category: "Decorations", user: user4, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/vase.jpg"), filename: "decorations.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Oil painting", category: "Decorations", user: user5, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/OilPainting.jpg"), filename: "decorations.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Fairy lights", category: "Decorations", user: user1, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/FairyLights.jpg"), filename: "decorations.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Elephant lamp", category: "Decorations", user: user2, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/ElephantLamp.jpg"), filename: "decorations.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Banksy print", category: "Decorations", user: user3, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/BanksyPrint.jpg"), filename: "decorations.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "DVD collection", category: "Other", user: user4, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/DVDs.jpg"), filename: "other.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Rubber Duck", category: "Other", user: user5, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/RubberDuck.jpg"), filename: "other.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Stapler", category: "Other", user: user1, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/stapler.jpg"), filename: "other.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Fridge Magnets", category: "Other", user: user2, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/FridgeMagnets.jpg"), filename: "other.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Hamster ball", category: "Other", user: user3, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/HamsterBall.jpg"), filename: "other.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Multi-tool", category: "Other", user: user4, description: generate_description, swapzi_points: (100..250).to_a.sample })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/MultiTool.jpg"), filename: "other.jpg", content_type: "image/jpg")
item.save!
item = Item.new({ name: "Golden paperclip", category: "Other", user: user5, description: generate_description, swapzi_points: (100..250).to_a.sample, swap_counter: 16 })
item.photo.attach(io: File.open("app/assets/images/seed_images/new_seeds/GoldenPaperclip.jpg"), filename: "other.jpg", content_type: "image/jpg")
item.save!
