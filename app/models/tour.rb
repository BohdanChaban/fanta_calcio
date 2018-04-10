class Tour < ApplicationRecord
  has_many :games, dependent: :destroy

  NUMBERS = (1..38)

  validates :number, presence: true, uniqueness: true, inclusion: { in: NUMBERS }
  validates :base_date, presence: true
end
