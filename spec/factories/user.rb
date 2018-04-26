FactoryBot.define do
  factory :user do
    @pass = "password"

    email 'calcio@example.com'
    first_name 'Calcio'
    last_name 'Rossoneri'
    password @pass

    factory :user_for_registration do
      password_confirmation @pass
    end

    factory :user_with_team do
      after(:create) do |user|
        create(:team, user: user)
      end
    end

    factory :user_with_team_and_players do
      after(:create) do |user|
        create(:team_with_players, user: user)
      end
    end

    factory :user_with_squad do
      after(:create) do |user|
        create(:team_with_squad, user: user)
      end
    end
  end
end
