# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: 'patryk@example.com',
  password: 'password'
)

10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email(:first_name),
    password: 'password'
  )
end

puts "#{User.all.count} users created"

User.all.each do |user|
  10.times do
    Exercise.create!(
      duration_in_min: Faker::Number.number(2),
      workout: Faker::RickAndMorty.quote,
      workout_date: Faker::Date.between(7.days.ago, Date.today),
      user_id: user.id
    )
  end
end

puts "#{Exercise.all.count} exercises created"
