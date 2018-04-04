class Club < ApplicationRecord
  has_many :players, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  after_create :update_info
  after_create :update_logo
  after_create :create_players

  private

  def update_info
    params = Clubs::DataParser.call(name)

    self.update(params)
  end

  def update_logo
    self.update(logo: "https://content.fantagazzetta.com/web/img/team/#{name}.png")
  end

  def create_players
    Clubs::PlayersCreator.call(self)
  end
end
