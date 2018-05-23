FactoryBot.define do
  factory :squad do
    association :tour, factory: :tour # tour 'Tour.first'

    factory :squad_with_members do
      after(:create) do |squad|
        create(:member, player: Player.gk.first, squad: squad)
        Player.df.limit(4).each do |player|
          create(:member, player: player, squad: squad)
        end
        Player.mf.limit(3).each do |player|
          create(:member, player: player, squad: squad)
        end
        Player.fw.limit(3).each do |player|
          create(:member, player: player, squad: squad)
        end
        Player.all.order(id: :desc).limit(7).each do |player|
          create(:member, player: player, squad: squad, status: 1)
        end
      end
    end
  end
end
