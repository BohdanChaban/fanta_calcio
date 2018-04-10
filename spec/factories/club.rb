FactoryBot.define do
  factory :club do
    name 'milan'
  end

  factory :club_with_games, parent: :club do
    after(:create) do |club|
      create(:tour, number: 1)
      create(:club, name: 'inter')
      create(:game, host: club, guest: Club.last, tour: Tour.last)
    end
  end
end
