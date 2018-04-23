class Game < ApplicationRecord
  belongs_to :tour
  belongs_to :host, class_name: 'Club', foreign_key: 'host_id'
  belongs_to :guest, class_name: 'Club', foreign_key: 'guest_id'

  validates :host, presence: true
  validates :guest, presence: true
  validates :tour, presence: true
  validates :start_time, presence: true

  def host_goals
    result[0].to_i
  end

  def guest_goals
    result[2].to_i
  end
end
