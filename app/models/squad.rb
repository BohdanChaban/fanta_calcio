class Squad < ApplicationRecord
  belongs_to :tour
  belongs_to :team
  has_many :members, dependent: :destroy

  validates :tour_id, presence: true, uniqueness: { scope: :team_id }
  validates :team_id, presence: true
end
