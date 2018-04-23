class Season < ApplicationRecord
  has_many :tours, dependent: :destroy

  validates :years, presence: true, uniqueness: true
end
