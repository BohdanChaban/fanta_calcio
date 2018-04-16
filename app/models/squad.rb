class Squad < ApplicationRecord
  belongs_to :tour
  belongs_to :team
  has_many :members
  accepts_nested_attributes_for :members

  validates :tour_id, presence: true
  validates :team_id, presence: true
end
