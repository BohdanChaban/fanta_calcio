# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

case Rails.env
when 'test'
  tours_numbers = (1..2)
  clubs = YAML.load(IO.read Rails.root.join('spec', 'fixtures', 'clubs.yml'))[0..9]
else
  tours_numbers = (1..38)
  clubs = YAML.load(IO.read Rails.root.join('spec', 'fixtures', 'clubs.yml'))
end

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
