class Member < ApplicationRecord
  belongs_to :squad
  belongs_to :player

  delegate :name, :position, :club, to: :player
  delegate :tour, to: :squad

  enum status: {
    main: 0,
    reserve: 1
  }

  enum appearance: {
    choosed: 0,
    played: 1,
    replaced: 2
  }

  validates :squad_id, presence: true
  validates :player_id, presence: true
  validates :status, presence: true
  validates :appearance, presence: true
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

  scope :main_with_points, -> { main.where('points > 0') }
  scope :missed, -> { main.choosed.where(points: 0) }
  scope :alternate, ->(position) { joins(:player).reserve.where(players: { position: position }, appearance: 0) }
  scope :played_defenders, -> { joins(:player).played.where(players: { position: 'D' }) }

  def clean_sheet?
    %w[P D].include?(position) && club_clean_sheet
  end

  def club_clean_sheet
    game.host == club ? game.guest_goals.zero? : game.host_goals.zero?
  end

  def game
    @game ||= club.games.find_by(tour: tour)
  end
end
