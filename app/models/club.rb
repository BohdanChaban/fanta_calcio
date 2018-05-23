class Club < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :host_games, foreign_key: 'host_id', class_name: 'Game'
  has_many :guest_games, foreign_key: 'guest_id', class_name: 'Game'

  validates :name, presence: true, uniqueness: true

  after_create :update_info
  after_create :update_logo
  before_create :create_players

  def games
    Game.where('host_id = ? OR guest_id = ?', id, id)
  end

  private

  def update_info
    params = Clubs::Parser.call(html_page)

    update(params)
  end

  def update_logo
    update(logo: Api::Url.club_image(name))
  end

  def create_players
    self.players = Clubs::PlayersBuilder.call(self, html_page)
  end

  def html_page
    Nokogiri::HTML(
      RestClient.get(Api::Url.team(name))
    )
  end
end
