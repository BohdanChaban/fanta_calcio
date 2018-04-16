class Tour < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :squads
  belongs_to :season

  NUMBERS = (1..38)

  validates :number, presence: true, uniqueness: true, inclusion: { in: NUMBERS }
  validates :base_date, presence: true
  validates :season_id, presence: true
end
