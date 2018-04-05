class Club < ApplicationRecord
  has_many :players, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  after_create :update_info
  after_create :update_logo
  before_create :create_players

  private

  def update_info
    params = Clubs::Parser.call(name)

    update(params)
  end

  def update_logo
    update(logo: Api::Url.club_image(name))
  end

  def create_players
    self.players = Clubs::PlayersBuilder.call(self)
  end
end
