class Tour < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :squads
  belongs_to :season

  NUMBERS = (1..38)

  validates :number, presence: true, uniqueness: { scope: :season_id }, inclusion: { in: NUMBERS }
  validates :base_date, presence: true
  validates :season_id, presence: true

  scope :future, -> { where('base_date > ?', Time.now) }
  scope :next, -> { future.first }
end
