FactoryBot.define do
  factory :team do
    name 'Rossoneri'

    factory :team_with_players do
      after(:create) do |team|
        Player.gk.limit(3).each do |player|
          player.update(team: team)
        end
        Player.df.limit(8).each do |player|
          player.update(team: team)
        end
        Player.mf.limit(8).each do |player|
          player.update(team: team)
        end
        Player.fw.limit(6).each do |player|
          player.update(team: team)
        end
      end
    end

    factory :team_with_squad do
      after(:create) do |team|
        create(:squad_with_members, team: team)
      end
    end
  end
end
