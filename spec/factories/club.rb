FactoryBot.define do
  factory :club do
    name 'milan'
  end

  factory :club_with_games, parent: :club do
    after(:create) do |club|
      create(:season, years: '2017-18')
      create(:tour, number: 1, season: Season.last)
      create(:club, name: 'inter')
      create(:game, host: club, guest: Club.last, tour: Tour.last)
    end
  end
end
