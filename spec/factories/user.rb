FactoryBot.define do
  factory :user do
    email 'calcio@example.com'
    first_name 'Calcio'
    last_name 'Rossoneri'
    password '12345678'
  end

  factory :user_with_team, parent: :user do
    after(:create) do |user|
      create(:team, user: user)
    end
  end
end
