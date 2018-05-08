# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tours_numbers = (1..2)
# tours_numbers = (1..38)
clubs = YAML.load(IO.read Rails.root.join('spec', 'fixtures', 'clubs.yml'))

clubs.each do |club|
  Club.create(name: club.downcase) unless Club.exists?(name: club)
  p "Club #{club} is successfully created"
end

season = Season.create(years: '2017-18')
p "Season #{season.years} is successfully created"

tours_numbers.each do |number|
  Tours::Creator.call(number)
  p "Tour ##{number} is successfully created"
end
