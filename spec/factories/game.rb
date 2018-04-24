FactoryBot.define do
  factory :game do
    start_time '2018-04-06 13:55:42'
    host Club.last
    guest Club.first
    tour Tour.first
    result '2-1'
  end
end
