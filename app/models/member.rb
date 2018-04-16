class Member < ApplicationRecord
  belongs_to :squad
  belongs_to :player

  enum status: {
    main: 0,
    reserve: 1
  }

  validates :squad_id, presence: true
  validates :player_id, presence: true
  validates :status, presence: true
  validates :total_score, presence: true
  validates :points, presence: true
  validates :scored_goals, presence: true
  validates :scored_penalties, presence: true
  validates :conceded_goals, presence: true
  validates :missed_penalties, presence: true
  validates :assists, presence: true
  validates :clean_sheets, presence: true
  validates :yellow_cards, presence: true
  validates :red_cards, presence: true
  validates :own_goals, presence: true
end
