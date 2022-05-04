# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Add Faker support
require 'faker'

# Create a few users
# standard users with known credentials
User.create(email: "spaquet@test.com", password: "123456", nickname: "Papa", first_name: "Seb", last_name: "Paquet")

# a bunch of random users
10.times do
  User.create(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    nickname: Faker::Internet.user_name,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

# add ActionText to the users as their bio
User.all.each do |user|
  ActionText::RichText.create!(record_type: 'User', record_id: user.id, name: 'bio', body: Faker::Lorem.paragraphs(number: 2).join("\n"))
end