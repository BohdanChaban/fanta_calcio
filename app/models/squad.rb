class Squad < ApplicationRecord
  belongs_to :tour
  belongs_to :team
  has_many :members

  validates :tour_id, presence: true
  validates :team_id, presence: true
  validates :tour_id, uniqueness: { scope: :team_id }
end
