module Clubs
  class PlayersBuilder
    def self.call(club)
      new(club).call
    end

    attr_accessor :club

    def initialize(club)
      @club = club
    end

    def call
      players_css.inject([]) do |memo, player|
        player_info = {
          name: player.children[1].text,
          position: player.children[2].text,
          init_price: player.children[4].text,
          actual_price: player.children[5].text,
          avatar: avatar_url(player.children[1].text),
          club: club
        }

        memo << Player.new(player_info)
        memo
      end
    end

    private

    def players_css
      @players_css ||= html_page.css('table')[0].children[1].children
    end

    def avatar_url(name)
      Api::Url.image(name)
    end

    def html_page
      Nokogiri::HTML(RestClient.get(
        Api::Url.team(club.name))
      )
    end
  end
end
