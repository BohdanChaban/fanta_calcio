class Team < ApplicationRecord
  belongs_to :user
  has_many :players
  has_many :squads

  validates :user_id, presence: true
  validates :name, presence: true
end
