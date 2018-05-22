FactoryBot.define do
  factory :member do
    squad 'Squad.first_or_create'
    player 'Player.first'
  end
end
