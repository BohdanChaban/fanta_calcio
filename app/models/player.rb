class Player < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :club
  has_many :members

  validates :club_id, presence: true
  validates :name, presence: true
  validates :position, presence: true
  validates :init_price, presence: true
  validates :actual_price, presence: true

  scope :gk, -> { where(position: 'P') }
  scope :df, -> { where(position: 'D') }
  scope :mf, -> { where(position: 'C') }
  scope :fw, -> { where(position: 'A') }
end
